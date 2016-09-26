A = load('C:\Users\Matthias\Documents\Dropbox\Ubuntu Connection\Exercise 2\Part 1\window2_1.txt');
S1 = load('C:\Users\Matthias\Documents\Dropbox\Ubuntu Connection\Exercise 2\Part 1\I1.txt');
S2 = load('C:\Users\Matthias\Documents\Dropbox\Ubuntu Connection\Exercise 2\Part 1\I2.txt');
S3 = load('C:\Users\Matthias\Documents\Dropbox\Ubuntu Connection\Exercise 2\Part 1\I3.txt');
S4 = load('C:\Users\Matthias\Documents\Dropbox\Ubuntu Connection\Exercise 2\Part 1\I4.txt');
S5 = load('C:\Users\Matthias\Documents\Dropbox\Ubuntu Connection\Exercise 2\Part 1\I5.txt');
S6 = load('C:\Users\Matthias\Documents\Dropbox\Ubuntu Connection\Exercise 2\Part 1\I6.txt');
S7 = load('C:\Users\Matthias\Documents\Dropbox\Ubuntu Connection\Exercise 2\Part 1\I7.txt');
S8 = load('C:\Users\Matthias\Documents\Dropbox\Ubuntu Connection\Exercise 2\Part 1\I8.txt');
S9 = load('C:\Users\Matthias\Documents\Dropbox\Ubuntu Connection\Exercise 2\Part 1\I9.txt');
S10 = load('C:\Users\Matthias\Documents\Dropbox\Ubuntu Connection\Exercise 2\Part 1\I10.txt');
S11 = load('C:\Users\Matthias\Documents\Dropbox\Ubuntu Connection\Exercise 2\Part 1\I11.txt');
S12 = load('C:\Users\Matthias\Documents\Dropbox\Ubuntu Connection\Exercise 2\Part 1\I12.txt');
S13 = load('C:\Users\Matthias\Documents\Dropbox\Ubuntu Connection\Exercise 2\Part 1\I13.txt');
B1 = load('C:\Users\Matthias\Documents\Dropbox\Ubuntu Connection\Exercise 2\Part 1\B1.txt');
B2 = load('C:\Users\Matthias\Documents\Dropbox\Ubuntu Connection\Exercise 2\Part 1\B2.txt');
B3 = load('C:\Users\Matthias\Documents\Dropbox\Ubuntu Connection\Exercise 2\Part 1\B3.txt');
B4 = load('C:\Users\Matthias\Documents\Dropbox\Ubuntu Connection\Exercise 2\Part 1\B4.txt');
B5 = load('C:\Users\Matthias\Documents\Dropbox\Ubuntu Connection\Exercise 2\Part 1\B5.txt');
B6 = load('C:\Users\Matthias\Documents\Dropbox\Ubuntu Connection\Exercise 2\Part 1\B6.txt');
B7 = load('C:\Users\Matthias\Documents\Dropbox\Ubuntu Connection\Exercise 2\Part 1\B7.txt');
B8 = load('C:\Users\Matthias\Documents\Dropbox\Ubuntu Connection\Exercise 2\Part 1\B8.txt');
B9 = load('C:\Users\Matthias\Documents\Dropbox\Ubuntu Connection\Exercise 2\Part 1\B9.txt');
B10 = load('C:\Users\Matthias\Documents\Dropbox\Ubuntu Connection\Exercise 2\Part 1\B10.txt');


figure(1)
hold on
plot(S1(:,1), S1(:,2), 'r-')
plot(B1(:,1), B1(:,2), 'b-')
plot(A(:,1), A(:,2), 'c-')

plot(S1(:,1), S1(:,2), 'r-')
plot(S2(:,1), S2(:,2), 'r-')
plot(S3(:,1), S3(:,2), 'r-')
plot(S4(:,1), S4(:,2), 'r-')
plot(S5(:,1), S5(:,2), 'r-')
plot(S6(:,1), S6(:,2), 'r-')
plot(S7(:,1), S7(:,2), 'r-')
plot(S8(:,1), S8(:,2), 'r-')
plot(S9(:,1), S9(:,2), 'r-')
plot(S10(:,1), S10(:,2), 'r-')
plot(S11(:,1), S11(:,2), 'r-')
plot(S12(:,1), S12(:,2), 'r-')
plot(S13(:,1), S13(:,2), 'r-')
plot(B1(:,1), B1(:,2), 'b-')
plot(B2(:,1), B2(:,2), 'b-')
plot(B3(:,1), B3(:,2), 'b-')
plot(B4(:,1), B4(:,2), 'b-')
plot(B5(:,1), B5(:,2), 'b-')
plot(B6(:,1), B6(:,2), 'b-')
plot(B7(:,1), B7(:,2), 'b-')
plot(B8(:,1), B8(:,2), 'b-')
plot(B9(:,1), B9(:,2), 'b-')
plot(B10(:,1), B10(:,2), 'b-')
xlabel('Time [sec]')
ylabel('Window size [KB or packets]')
legend('Slow start phase', 'Additive increase phase', 'Undefined')
hold off

figure(2)
hold on
plot(S1(:,1), S1(:,2), 'r+-')
plot(B1(:,1), B1(:,2), 'b+-')
plot(A(:,1), A(:,2), 'c-')

plot(S1(:,1), S1(:,2), 'r+-')
plot(S2(:,1), S2(:,2), 'r+-')
plot(S3(:,1), S3(:,2), 'r+-')
plot(S4(:,1), S4(:,2), 'r+-')
plot(S5(:,1), S5(:,2), 'r+-')
plot(S6(:,1), S6(:,2), 'r+-')
plot(S7(:,1), S7(:,2), 'r+-')
plot(S8(:,1), S8(:,2), 'r+-')
plot(S9(:,1), S9(:,2), 'r+-')
plot(S10(:,1), S10(:,2), 'r+-')
plot(S11(:,1), S11(:,2), 'r-')
plot(S12(:,1), S12(:,2), 'r-')
plot(S13(:,1), S13(:,2), 'r-')
plot(B1(:,1), B1(:,2), 'b+-')
plot(B2(:,1), B2(:,2), 'b+-')
plot(B3(:,1), B3(:,2), 'b+-')
plot(B4(:,1), B4(:,2), 'b+-')
plot(B5(:,1), B5(:,2), 'b+-')
plot(B6(:,1), B6(:,2), 'b+-')
plot(B7(:,1), B7(:,2), 'b+-')
plot(B8(:,1), B8(:,2), 'b+-')
plot(B9(:,1), B9(:,2), 'b+-')
plot(B10(:,1), B10(:,2), 'b+-')
xlabel('Time [sec]')
ylabel('Window size [KB or packets]')
legend('Slow start phase', 'Additive increase phase', 'Undefined')
hold off