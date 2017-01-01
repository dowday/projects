clc
clear
close all

pcn= [0.0 0.0 0.6 0.6];
pmn= [0.1 0.01 0.1 0.01];
gmaxt= [10^3 10^4 10^5];
    for jg=1:3
        FName = strcat('CumulativeEmp',num2str(gmaxt(jg)/100));    ResF = 'Results';   mkdir(ResF,FName);    
        CurrentF = pwd;
        F2SaveRes= strcat(CurrentF,'\',ResF, strcat('\', FName));    fnamefigures = F2SaveRes;
        for jjk=1:4
            pc = pcn(jjk);
            pm=pmn(jjk);
            pmsptr = strsplit(num2str(pm),'.');pmstr=strcat(pmsptr(1), pmsptr(end));
            pcsptr = strsplit(num2str(pc),'.');pcstr=strcat(pcsptr(1), pcsptr(end));
%             pc = 0;
%             pm = 0.1;%0.01
            pop_size = 100;
            g_max = (gmaxt(jg))/pop_size;
            generation = 0;
            optimum = -1356;% -1356;
            relative_dist1 = 0.99*optimum;%1.0 % distance to optimum
            relative_dist2 = 0.975*optimum;%2.5 % distance to optimum
            cnt_rel_dist1 = 0;
            cnt_rel_dist2 = 0;
            cnt_opt = 0;
            vect_rel_dist1 = zeros(1,g_max);
            vect_rel_dist2 = zeros(1,g_max);
            vect_cnt_opt = zeros(1,g_max);
            %initialize population
            %2 columns : x,y 
            population = round(rand(pop_size,2)*990)+10;
            %new_population = Inf(100,2);

            while generation ~= g_max
                generation = generation +1;

                %compute the fitness of each member of the population
                for i=1:pop_size
                    fitnesses(i) = fitness(population(i,1),population(i,2));
                end

               %selection
               %the tournament selects 5 individuals and returns the winner
               for j=1:pop_size
                    [xs ys] = tournament(population,fitnesses,pop_size,5);
                    new_population(j,1) = xs;
                    new_population(j,2) = ys;
               end
               population = new_population;
               for i=1:pop_size-1
                   rndc = rand();
                   if rndc <= pc
                       %             [xc, yc] = crossover(population(i,1), population(i+1,2));
                       %             population(i,1) = xc;
                       %             population(i,2) = yc;
                       [x1, x2] = crossover(population(i,1), population(i+1,1));
                       [y1, y2] = crossover(population(i+1,2), population(i,2));
                       population(i,1) = x1;
                       population(i,2) = y1;
                       population(i+1,1) = x2;
                       population(i+1,2) = y2;
                   end
               end
               for i=1:pop_size
                   %rndm = rand();
                   %if rndm <= pm
                   population(i,1) = mutation(population(i,1),pm);

                   population(i,2) = mutation(population(i,2),pm);
                   %end 
               end

               if ~isempty(find(fitnesses <=relative_dist1 ))
                   cnt_rel_dist1 = cnt_rel_dist1+1;
                   vect_rel_dist1(generation) = cnt_rel_dist1/generation;
               else
                   %garder valeur precedente pour afficage (courbe continue)
                   if generation > 1
                       vect_rel_dist1(generation) = vect_rel_dist1(generation-1);
                   end
               end
               if ~isempty(find(fitnesses <=relative_dist2 ))
                   cnt_rel_dist2 = cnt_rel_dist2+1;
                   vect_rel_dist2(generation) = cnt_rel_dist2/generation;
               else
                   if generation > 1
                       vect_rel_dist2(generation) = vect_rel_dist2(generation-1);
                   end
               end
               if ~isempty(find(fitnesses <=optimum ))
                   cnt_opt = cnt_opt+1;
                   vect_cnt_opt(generation) = cnt_opt/generation;
               else
                   if generation > 1
                       vect_cnt_opt(generation) = vect_cnt_opt(generation-1);
                   end
               end


            end
            fig2 = figure;hold on;        
            figname1 = ['figCumuEmpPr','s',char(pcstr),'s',char(pmstr)];
            title(['Cum. emp. prob. with P_{crossover}= ',num2str(pc),', P_{mutation}= ',num2str(pm),', generation= ',num2str(g_max),])
            h1 = plot([1:g_max],vect_cnt_opt,'LineWidth',2,...
                'MarkerEdgeColor','k',...
                'MarkerFaceColor','g',...
                'MarkerSize',.2);
            h2 = plot([1:g_max],vect_rel_dist1,'LineWidth',2,...
                'MarkerEdgeColor','k',...
                'MarkerFaceColor','b',...
                'MarkerSize',.2);hold on

            h3 = plot([1:g_max],vect_rel_dist2,'LineWidth',2,...
                'MarkerEdgeColor','r',...
                'MarkerFaceColor','r',...
                'MarkerSize',.2);   
            legend([h1 h2 h3],'op','Relative distance to optimum = 1.0 %','Relative distance to optimum = 2.5 %','Location','best')
            hold off
            print(fullfile(fnamefigures,figname1),'-depsc')
            print(fullfile(fnamefigures,figname1),'-djpeg')
            fignametosave1 = [char(figname1),'.fig'];
            savefig(fig2,fullfile(fnamefigures,fignametosave1),'compact');
        end
    end