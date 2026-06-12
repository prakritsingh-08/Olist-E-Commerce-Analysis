/*
========================================
    OLIST E-COMMERCE BUSINESS ANALYSIS
========================================

Author : Prakrit Kumar
Role   : Data Analyst
date   : start[ 05-06-2026 ] - end[ 10-06-2026 ]

This project uses SQL to analyze the
Olist E-Commerce dataset and answer
business questions to generate insights
for better decision-making.

========================================
*/

--  All tables...!!

select * from customers;
select * from order_items;
select * from orders;
select * from payments;
select * from product;
select * from reviews;
select * from sellers;

-- ============================================================
-- BASIC ANALYSIS
-- ============================================================

-- 1. Total customers

    select count(distinct customer_id) as total_customers
	from customers;

	-- total customer = 99441

-- 2. Total orders

    select count(distinct order_id) as total_orders
	from orders;
	
    -- total orders = 99441

-- 3. Total sellers

    select count(distinct seller_id) as total_sellers
	from sellers;

    -- total sellers = 3095

-- 4. Total products

    select count(distinct product_id) as total_product
    from product;

    -- total products = 32951

-- 5. Total reviews

    select count(distinct review_id) as total_reviews
	from reviews;

    -- total review = 98410

-- 6. Total revenue generated

    select sum(price) as total_revenue
	from order_items;

    -- total revenue = 13591643.70

-- 7. Average order value

	select round(avg(order_value), 2) as average_order_value
	from (
          select order_id,
		         sum(price) as order_value
		  from order_items
		  group by order_id
	);

    -- Average order value = 137.75 
	

-- 8. Total unique product categories

    select count(distinct product_category_name) as unique_product_categories
    from product;

    -- unique product categories = 74

-- 9. Order status distribution

    select order_status,
	       count(order_status) as total_order_status
    from orders
	group by order_status
	order by total_order_status desc;

	/*
		Order Status Distribution:
		
		Delivered   : 96,478
		Shipped     : 1,107
		Canceled    : 625
		Unavailable : 609
		Invoiced    : 314
		Processing  : 301
		Created     : 5
		Approved    : 2
	*/
		   
-- 10. Most used payment method

    select payment_type,
	       count(payment_type) as most_payment_type
    from payments
	group by payment_type
	order by most_payment_type desc;
	
	/* 
		credit_card  : 76795
	    boleto       : 19784
		voucher	     : 5775
		debit_card	 : 1529
		not_defined  : 3
	*/

-- ============================================================
-- JOIN BASED ANALYSIS
-- ============================================================

-- 11. Top 10 customers by number of orders

     select c.customer_id,
	 	    c.customer_city,
			count(order_id) as total_orders
	 from orders o
	 inner join customers c
	 on c.customer_id = o.customer_id
	 group by c.customer_id,c.customer_city
	 order by total_orders desc
	 limit 10;
	 
	 /*
         Top 10 customers by total orders:
		  
		- Customer 000161a058600d5901f007fab4c27140 from Itapecerica placed 1 order.
		- Customer 0001fd6190edaaf884bcaf3d49edf079 from Nova Venecia placed 1 order.
		- Customer 0002414f95344307404f0ace7a26f1d5 from Mendonca placed 1 order.
		- Customer 000379cdec625522490c315e70c7a9fb from Sao Paulo placed 1 order.
		- Customer 0004164d20a9e969af783496f3408652 from Valinhos placed 1 order.
		- Customer 000419c5494106c306a97b5635748086 from Niteroi placed 1 order.
		- Customer 00046a560d407e99b969756e0b10f282 from Rio de Janeiro placed 1 order.
		- Customer 00050bf6e01e69d5c0fd612f1bcfb69c from Ijui placed 1 order.
		- Customer 000598caf2ef4117407665ac33275130 from Oliveira placed 1 order.
		- Customer 00012a2ce6f8dcda20d059ce98491703 from Osasco placed 1 order.
	 */ 

-- 12. Top 10 customers by spending

   select c.customer_id,
          c.customer_city,
		  sum(oi.price + oi.freight_value) as total_spend
   from orders o
   join customers c
   on o.customer_id = c.customer_id
   join order_items oi
   on o.order_id = oi.order_id
   group by c.customer_id,c.customer_city
   order by total_spend desc
   limit 10;

   /*
		Top 10 customers by total product spend:
		
		- Customer 1617b1357756262bfa56ab541c47bc16 from Rio de Janeiro spent 13,664.08.
		- Customer ec5b2ba62e574342386871631fafd3fc from Vila Velha spent 7,274.88.
		- Customer c6e2731c5b391845f6800c97401a43a9 from Campo Grande spent 6,929.31.
		- Customer f48d464a0baaea338cb25f816991ab1f from Vitoria spent 6,922.21.
		- Customer 3fd6777bbce08a352fddd04e4a7cc8f6 from Marilia spent 6,726.66.
		- Customer 05455dfa7cd02f13d132aa7a6a9729c6 from Divinopolis spent 6,081.54.
		- Customer df55c14d1476a9a3467f131269c2477f from Araruama spent 4,950.34.
		- Customer e0a2412720e9ea4f26c1ac985f6a7358 from Goiania spent 4,809.44.
		- Customer 24bbf5fd2f2e1b359ee7de94defc4a15 from Maua spent 4,764.34.
		- Customer 3d979689f636322c62418b6346b1c6d2 from Joao Pessoa spent 4,681.78.
    */

-- 13. Top 10 sellers by revenue

   select s.seller_id,
   		  s.seller_city,
		  sum(oi.price + oi.freight_value) as total_revenue
   from order_items oi
   join sellers s
   on oi.seller_id = s.seller_id
   group by s.seller_id,s.seller_city
   order by total_revenue desc
   limit 10;

   /*
		Top 10 sellers by total revenue:
		
		- Seller 4869f7a5dfa277a7dca6462dcf3b52b2 from Guariba generated revenue of 249,640.70.
		- Seller 7c67e1448b00f6e969d365cea6b010ab from Itaquaquecetuba generated revenue of 239,536.44.
		- Seller 53243585a1d6dc2643021fd1853d8905 from Lauro de Freitas generated revenue of 235,856.68.
		- Seller 4a3ca9315b744ce9f8e9374361493884 from Ibitinga generated revenue of 235,539.96.
		- Seller fa1c13f2614d7b5c4749cbc52fecda94 from Sumare generated revenue of 204,084.73.
		- Seller da8622b14eb17ae2831f4ac5b9dab84a from Piracicaba generated revenue of 185,192.32.
		- Seller 7e93a43ef30c4f03f38b393420bc753a from Barueri generated revenue of 182,754.05.
		- Seller 1025f0e2d44d7041d6cf58b6550e0bfa from Sao Paulo generated revenue of 172,860.69.
		- Seller 7a67c85e85bb2ce8582c35f2203ad736 from Sao Paulo generated revenue of 162,648.38.
		- Seller 955fee9216a65b617aa5c0531780ce60 from Sao Paulo generated revenue of 160,602.68.
*/

-- 14. Bottom 10 sellers by revenue

   select s.seller_id,
   		  s.seller_city,
		  sum(oi.price + oi.freight_value) as total_revenue
   from order_items oi
   join sellers s
   on oi.seller_id = s.seller_id
   group by s.seller_id,s.seller_city
   order by total_revenue asc
   limit 10;

	/*
		Bottom 10 sellers by total revenue:
		
		- Seller cf6f6bc4df3999b9c6440f124fb2f687 from Sao Paulo generated revenue of 12.22.
		- Seller 77128dec4bec4878c37ab7d6169d6f26 from Sao Paulo generated revenue of 15.22.
		- Seller 1fa2d3def6adfa70e58c276bb64fe5bb from Sao Paulo generated revenue of 15.90.
		- Seller 4965a7002cca77301c82d3f91b82e1a9 from Sorocaba generated revenue of 16.36.
		- Seller 702835e4b785b67a084280efca355756 from Juiz de Fora generated revenue of 18.56.
		- Seller ad14615bdd492b01b0d97922e87cb87f from Tubarao generated revenue of 19.21.
		- Seller 3ac588cd562971392504a9e17130c40b from Limeira generated revenue of 19.29.
		- Seller c1dde11f12d05c478f5de2d7319ad3b2 from Sao Paulo generated revenue of 19.89.
		- Seller cc1f04647be106ba74e62b21f358af25 from Sao Paulo generated revenue of 20.19.
		- Seller b5f0712d22a873b6797ab6cc65c3fcba from Sao Paulo generated revenue of 21.28.
   */

-- 15. Top 10 product categories by revenue

   select p.product_category_name,
   		  sum(oi.price) as total_revenue
   from order_items oi
   join product p
   on oi.product_id = p.product_id
   group by p.product_category_name
   order by total_revenue desc
   limit 10;

	/*
		Top 10 Product Categories by Revenue:
			
		- beleza_saude            → 1,258,681.34
		- relogios_presentes      → 1,205,005.68
		- cama_mesa_banho         → 1,036,988.68
		- esporte_lazer           →   988,048.97
		- informatica_acessorios  →   911,954.32
		- moveis_decoracao        →   729,762.49
		- cool_stuff              →   635,290.85
		- utilidades_domesticas   →   632,248.66
		- automotivo              →   592,720.11
		- ferramentas_jardim      →   485,256.46
	
	*/


-- 16. Top 10 product categories by order count

        
   select p.product_category_name,
   		  count(order_id) as order_count
   from order_items oi
   join product p
   on oi.product_id = p.product_id
   group by p.product_category_name
   order by order_count desc
   limit 10;

   /*
		Top 10 Product Categories by Number of Orders:
			
		- cama_mesa_banho         → 11,115
		- beleza_saude            →  9,670
		- esporte_lazer           →  8,641
		- moveis_decoracao        →  8,334
		- informatica_acessorios  →  7,827
		- utilidades_domesticas   →  6,964
		- relogios_presentes      →  5,991
		- telefonia               →  4,545
		- ferramentas_jardim      →  4,347
		- automotivo              →  4,235
	
  */

-- 17. Revenue by customer state

   select c.customer_state,
		  sum(oi.price) as total_revenue	 
   from orders o
   join customers c
   on o.customer_id = c.customer_id
   join order_items oi
   on o.order_id = oi.order_id
   group by c.customer_state
   order by total_revenue desc
   limit 10;

   /*
		Top 10 Customer States by Revenue:
			
		- Customer State: SP | Revenue: 5,202,955.05
		- Customer State: RJ | Revenue: 1,824,092.67
		- Customer State: MG | Revenue: 1,585,308.03
		- Customer State: RS | Revenue:   750,304.02
		- Customer State: PR | Revenue:   683,083.76
		- Customer State: SC | Revenue:   520,553.34
		- Customer State: BA | Revenue:   511,349.99
		- Customer State: DF | Revenue:   302,603.94
		- Customer State: GO | Revenue:   294,591.95
		- Customer State: ES | Revenue:   275,037.31
	
   */
   
-- 18. Revenue by seller state

   select s.seller_state,
		  sum(oi.price) as total_revenue	 
   from order_items oi
   join sellers s
   on oi.seller_id = s.seller_id
   group by s.seller_state
   order by total_revenue desc
   limit 10;

   /*
		Top 10 Seller States by Revenue:
			
		- State: SP | Revenue: 8,753,396.21
		- State: PR | Revenue: 1,261,887.21
		- State: MG | Revenue: 1,011,564.74
		- State: RJ | Revenue:   843,984.22
		- State: SC | Revenue:   632,426.07
		- State: RS | Revenue:   378,559.54
		- State: BA | Revenue:   285,561.56
		- State: DF | Revenue:    97,749.48
		- State: PE | Revenue:    91,493.85
		- State: GO | Revenue:    66,399.21
	
   */

-- 19. Average review score by product category

   select distinct p.product_category_name,
          round(avg(r.review_score), 2) as avg_review_score
   from product p
   join order_items oi
   on p.product_id = oi.product_id
   join reviews r
   on oi.order_id = r.order_id
   group by p.product_category_name
   order by avg_review_score desc;
   
   /*
		Average Review Score by Product Category total (74 category) :

		- cds_dvds_musicais (4.64),              fashion_roupa_infanto_juvenil (4.50),     livros_interesse_geral (4.45),             construcao_ferramentas_ferramentas (4.44)
		- flores (4.42),                         livros_importados (4.40),                 livros_tecnicos (4.37),                    alimentos_bebidas (4.32)
		- malas_acessorios (4.32),               portateis_casa_forno_e_cafe (4.30),       fashion_esporte (4.26),                    fashion_calcados (4.23)
		- alimentos (4.22),                      cine_foto (4.21),                         musica (4.21),                             papelaria (4.19)
		- pet_shop (4.19),                       pcs (4.18),                               eletrodomesticos (4.17),                   brinquedos (4.16)
		- perfumaria (4.16),                     cool_stuff (4.15),                        eletroportateis (4.15),                    instrumentos_musicais (4.15)
		- beleza_saude (4.14),                   eletrodomesticos_2 (4.14),                fashion_bolsas_e_acessorios (4.14),        artes_e_artesanato (4.13)
		- moveis_quarto (4.12),                  tablets_impressao_imagem (4.12),          esporte_lazer (4.11),                      industria_comercio_e_negocios (4.10)
		- sinalizacao_e_seguranca (4.09),        dvds_blu_ray (4.08),                      automotivo (4.07),                         utilidades_domesticas (4.06)
		- bebidas (4.05),                        construcao_ferramentas_construcao (4.05), construcao_ferramentas_iluminacao (4.05),  construcao_ferramentas_jardim (4.05)
		- eletronicos (4.04),                    ferramentas_jardim (4.04),                artigos_de_natal (4.02),                   consoles_games (4.02)
		- market_place (4.02),                   relogios_presentes (4.02),                bebes (4.01),                              agro_industria_e_comercio (4.00)
		- la_cuisine (4.00),                     fashion_underwear_e_moda_praia (3.98),    climatizacao (3.97),                       moveis_cozinha_area_de_servico_jantar_e_jardim (3.96)
		- telefonia (3.95),                      artes (3.94),                             casa_construcao (3.94),                    informatica_acessorios (3.93)
		- cama_mesa_banho (3.90),                moveis_decoracao (3.90),                  moveis_sala (3.90),                        construcao_ferramentas_seguranca (3.84)
		- unknow (3.84),                         audio (3.83),                             casa_conforto (3.83),                      moveis_colchao_e_estofado (3.82)
		- fashion_roupa_feminina (3.78),         artigos_de_festas (3.77),                 telefonia_fixa (3.68),                     fashion_roupa_masculina (3.64)
		- casa_conforto_2 (3.63),                moveis_escritorio (3.49),                 pc_gamer (3.33),                           portateis_cozinha_e_preparadores_de_alimentos (3.27)
		- fraldas_higiene (3.26),                seguros_e_servicos (2.50)

*/


-- 20. Average review score by seller

   select distinct s.seller_id,
       round(avg(r.review_score), 2) as avg_review_score
   from sellers s
   join order_items oi
   on s.seller_id = oi.seller_id
   join reviews r
   on oi.order_id = r.order_id
   group by s.seller_id
   order by avg_review_score desc;

-- ============================================================
-- TIME SERIES ANALYSIS
-- ============================================================

-- 21. Monthly order trend

   select  
           extract(month from order_purchase_timestamp) as months,
           count(order_id) as total_orders
   from orders
   group by extract(month from order_purchase_timestamp)
   order by months asc;

   /*
		Monthly Order Trend:
		
		January   1 order  = 8069
		February  2 orders = 8508
		March     3 orders = 9893
		April     4 orders = 9343
		May       5 orders = 10573
		June      6 orders = 9412
		July      7 orders = 10318
		August    8 orders = 10843
		September 9 orders = 4305
		October   10 orders = 4959
		November  11 orders = 7544
		December  12 orders = 5674
   */
   
-- 22. Monthly revenue trend

   select  
           extract(month from o.order_purchase_timestamp) as months,
           sum(oi.price) as total_revenue
   from orders o
   join order_items oi
   on o.order_id = oi.order_id
   group by extract(month from order_purchase_timestamp)
   order by months asc;

   /*
		Monthly Revenue Trend:

		January   revenue = 1070343.23
		February  revenue = 1091481.73
		March     revenue = 1357557.74
		April     revenue = 1356574.98
		May       revenue = 1502588.82
		June      revenue = 1298162.91
		July      revenue = 1393538.70
		August    revenue = 1428658.01
		September revenue = 624814.05
		October   revenue = 713727.09
		November  revenue = 1010271.37
		December  revenue = 743925.07
   */
   
-- 23. Year-over-year revenue trend

   select  
           extract(year from o.order_purchase_timestamp) as years,
           sum(oi.price) as total_revenue
   from orders o
   join order_items oi
   on o.order_id = oi.order_id
   group by extract(year from order_purchase_timestamp)
   order by years asc;

   /*
		Year-over-Year Revenue Trend:
		
		2016 revenue = 49785.92
		2017 revenue = 6155806.98
		2018 revenue = 7386050.80
   */
   
-- 24. Orders by weekday 
  
   --(solve use of chatgpt..!!)

    SELECT  
	    TO_CHAR(order_purchase_timestamp, 'FMDay') AS weekday,
	    COUNT(order_id) AS total_orders
	FROM orders
	GROUP BY TO_CHAR(order_purchase_timestamp, 'FMDay'), EXTRACT(DOW FROM order_purchase_timestamp)
	ORDER BY EXTRACT(DOW FROM order_purchase_timestamp);
	
    /*
		Orders by Weekday:
		
		Sunday    orders = 11960
		Monday    orders = 16196
		Tuesday   orders = 15963
		Wednesday orders = 15552
		Thursday  orders = 14761
		Friday    orders = 14122
		Saturday  orders = 10887
    */

-- 25. Average delivery time by month

   -- (some help to chatgpt...!!)

   select 
         to_char(order_purchase_timestamp, 'FMMonth') as months,
         avg(order_delivered_customer_date - order_purchase_timestamp) as avg_delivered_time
   from orders
   where order_delivered_customer_date is not null
   group by to_char(order_purchase_timestamp, 'FMMonth') , extract(month from order_purchase_timestamp)
   order by  extract(month from order_purchase_timestamp) asc;

   /*
		Average Delivery Time by Month:
		
		January   avg_delivery_time = 13 days 22:38:00
		February  avg_delivery_time = 15 days 28:28:18
		March     avg_delivery_time = 14 days 33:47:44
		April     avg_delivery_time = 11 days 32:44:38
		May       avg_delivery_time = 10 days 33:15:27
		June      avg_delivery_time = 9 days 28:20:17
		July      avg_delivery_time = 9 days 23:25:01
		August    avg_delivery_time = 8 days 26:10:23
		September avg_delivery_time = 11 days 20:40:21
		October   avg_delivery_time = 11 days 31:05:58
		November  avg_delivery_time = 14 days 27:52:01
		December  avg_delivery_time = 14 days 33:25:53
  */
	
-- ============================================================
-- BUSINESS ANALYSIS
-- ============================================================

-- 26. Product categories with high revenue but low review scores

   select 
          p.product_category_name,
          sum(oi.price + oi.freight_value) as total_revenue,
		  round(avg(r.review_score), 2) as avg_review_score
   from order_items oi
   join product p
   on oi.product_id = p.product_id
   join reviews r
   on oi.order_id = r.order_id
   group by p.product_category_name
   having sum(oi.price + oi.freight_value) >= 800000 and round(avg(r.review_score), 2) <= 4
   order by avg_review_score asc;

   /*
		Product Categories with High Revenue but Low Review Scores:
		
		cama_mesa_banho          revenue = 1244950.00   avg_review_score = 3.90
		moveis_decoracao         revenue = 902472.18    avg_review_score = 3.90
		informatica_acessorios   revenue = 1062184.42   avg_review_score = 3.93
   */

-- 27. States generating the highest revenue

    select c.customer_state,
		  sum(oi.price + oi.freight_value) as total_revenue	 
   from orders o
   join customers c
   on o.customer_id = c.customer_id
   join order_items oi
   on o.order_id = oi.order_id
   group by c.customer_state
   order by total_revenue desc;

   /*
		Customer State    Revenue        Customer State    Revenue
		SP               5921678.12      CE               275606.30
		RJ               2129681.98      PA               217647.11
		MG               1856161.49      MT               186168.96
		RS               885826.76       MA               151171.99
		PR               800935.44       PB               140987.81
		BA               611506.67       MS               135956.67
		SC               610213.60       PI               108132.28
		DF               353229.44       RN               101895.08
		GO               347706.93       AL               96229.40
		ES               324801.91       SE               73032.32
		PE               322237.69       TO               61354.42
		AC               19669.70        RO               57558.02
		AP               16262.80        AM               27835.73
		RR               10064.62
   */


-- 28. Impact of delivery time on customer review scores

   select 
         round(avg(r.review_score), 2) as avg_review_score,
		 avg(o.order_delivered_customer_date - o.order_purchase_timestamp) as delivery_time
   from orders o
   join reviews r
   on o.order_id = r.order_id
   where o.order_delivered_customer_date is not null
   group by r.review_score
   order by avg_review_score desc;

   /*
		Review Score vs Delivery Time:
		
		Review Score 5.00 → 10 days 16:31:35
		Review Score 4.00 → 11 days 31:29:47
		Review Score 3.00 → 13 days 30:17:13
		Review Score 2.00 → 16 days 15:51:14
		Review Score 1.00 → 20 days 31:28:26
   */
		 
-- 29. Payment method contributing the highest revenue

    select p.payment_type,
	       sum(oi.price + freight_value) as total_revenue
    from payments p
	join order_items oi
	on p.order_id = oi.order_id
	group by p.payment_type
	order by total_revenue desc;
	
    /*
		Payment Method vs Revenue:
		
		credit_card  → revenue = 12723914.88
		boleto       → revenue = 2842240.29
		voucher      → revenue = 785081.94
		debit_card   → revenue = 215306.74
    */

-- 30. Revenue contribution (%) by product category

   -- use of chatgpt..!!

	SELECT 
	    p.product_category_name,
	    SUM(oi.price + oi.freight_value) AS revenue,
        round(SUM(oi.price + oi.freight_value) * 100.0 / SUM(SUM(oi.price + oi.freight_value)) OVER(), 2)
		AS revenue_percentage
	FROM order_items oi
	JOIN product p
    ON oi.product_id = p.product_id
	GROUP BY p.product_category_name
	ORDER BY revenue_percentage DESC;

-- ============================================================
-- WINDOW FUNCTION ANALYSIS
-- ============================================================

-- take some help only some help for window function question only...!!

-- 31. Rank sellers by revenue

   select  
         s.seller_id,
		 SUM(oi.price + oi.freight_value) AS revenue,
         rank() over(order by sum(oi.price + oi.freight_value) desc) as revenue_rank
   from order_items oi
   join sellers s
   on oi.seller_id = s.seller_id
   group by s.seller_id;

-- 32. Top 3 sellers in each state

   select *
   from (
         select 
		       s.seller_id,
			   s.seller_state,
			   sum(oi.price + oi.freight_value) as revenue,
			   row_number() over(partition by s.seller_state order by sum (oi.price + oi.freight_value) desc) as rnk
	      from order_items oi
		  join sellers s
		  on oi.seller_id = s.seller_id
		  group by s.seller_id,s.seller_state
		  		 
   ) t

   where rnk <= 3;
    
-- 33. Running monthly revenue

   select 
         months,
		 sum(revenue) over(order by month_number) as running_total
   from(
        select 
		      extract(month from o.order_purchase_timestamp) as month_number,
		      to_char(o.order_purchase_timestamp , 'FMMonth') as months,
		      sum(oi.price + oi.freight_value) as revenue
	    from orders o
		join order_items oi
		on o.order_id = oi.order_id
		group by to_char(o.order_purchase_timestamp , 'FMMonth') , extract(month from o.order_purchase_timestamp)
		
   ) t		 
   order by month_number asc;

-- 34. Dense rank product categories by sales

   select 
         category_name,
		 revenue,
		 dense_rank() over( order by revenue desc) as rnk
   from( 
         select
		       p.product_category_name as category_name,
		       sum(oi.price + oi.freight_value) as revenue
		 from order_items oi
		 join product p
		 on oi.product_id = p.product_id
		 group by  p.product_category_name
		 
       ) t
   order by revenue desc;
   

-- 35. Month-over-month revenue growth

   WITH monthly_revenue AS (
   SELECT
        EXTRACT(MONTH FROM o.order_purchase_timestamp) AS month_no,
        TO_CHAR(o.order_purchase_timestamp, 'Mon') AS month,
        SUM(oi.price + oi.freight_value) AS revenue
   FROM orders o
   JOIN order_items oi
   ON o.order_id = oi.order_id
   GROUP BY 1, 2
 )

   SELECT
         month_no,
         month,
         revenue,
         LAG(revenue) OVER (ORDER BY month_no) AS previous_month_revenue,
         ROUND((revenue - LAG(revenue) OVER (ORDER BY month_no)) * 100.0 / LAG(revenue) OVER (ORDER BY month_no),2)
		 AS growth_percentage
   FROM monthly_revenue
   ORDER BY month_no;


-- 36. Top category in each year

	SELECT
	     year,
	     product_category_name,
	     revenue
	FROM (
	   SELECT
	       EXTRACT(YEAR FROM o.order_purchase_timestamp) AS year,
	       p.product_category_name,
	       SUM(oi.price + oi.freight_value) AS revenue,
	       DENSE_RANK() OVER ( PARTITION BY EXTRACT(YEAR FROM o.order_purchase_timestamp) ORDER BY SUM(oi.price + oi.freight_value) DESC) 
		   AS rnk
	    FROM orders o
	    JOIN order_items oi
	    ON o.order_id = oi.order_id
	    JOIN products p
	    ON oi.product_id = p.product_id
	    GROUP BY
	        EXTRACT(YEAR FROM o.order_purchase_timestamp),
	        p.product_category_name
	) t
	WHERE rnk = 1
	ORDER BY year;
