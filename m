Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752684AbeEOJNE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 05:13:04 -0400
Received: from mail-bn3nam01on0041.outbound.protection.outlook.com ([104.47.33.41]:43066
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752595AbeEOJM6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 05:12:58 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com;
Date: Tue, 15 May 2018 17:12:08 +0800
From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: berlin2: fix irq type for arm twd timer
Message-ID: <20180515171208.4f1c0b21@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TY1PR01CA0205.jpnprd01.prod.outlook.com (2603:1096:403::35)
 To DM5PR03MB2635.namprd03.prod.outlook.com (2603:10b6:3:43::9)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR03MB2635;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2635;3:7fnO2G5kPA8ZUSz4fHGEaeG683tWel5Q1nmWnjcrmG1I+dKzQDJjpLA+KVdXXKkWj3kKn48h4QSPs6OVi5eVvXNt/CRCe1HD+OEvJ7WFnNNG8E0pehG58y2EmfpRy4wdD0Q6vAykCUbfIflokZr8PirlgpTQYgNWS9O0qgQoNh6hbEadAHijvLYnop9MytvHBe+1715m73dKqpmc8ZmAa85AuTZ3goVmFOMrA6KorekYz/4pEtVPeJyfWOBpYkDO;25:MQw5QUm6f9gSFNnGpo4G1GpEtWTR+JJf69qTQbuaDmluPzf9LkhIx/1R6bC625xh431oY8VLR//iEjf0SYOsb0A+C6j3//Ti3zesJKjl2tALdQG2Hb/wh5SS11nUcmA+U+Nq8lu3mu+3bgop5zYph4ouL6kODJFkNQkiIYZ6ZjZj9uILC9UdLKZP5fFAAc8P4cnO4Mjgv2+jVva+lumrkHJUZieUMI8mxlL2FNOwf7aiIQOM0YmaDaNikgcbod46sTVRF6W2mrUUCPevvsS0PH3iQR6XIibvmA/BbOlQqa71uL7B7QgFV7v0hQ9ZOFApukFvhKMvQOQqJqJfBu+JIQ==;31:Imze47mjgE3h/szwfkZfs5EPSIP/Mhh/iS7cKe0iu8rF/Yb2xvYiqijfzaznrgzAKt/rJRvDg0Yrid5iUeZKp7HnWcGTImBqLLq3BgY0UihCqup/j2kfMQ8TQtTXQsMHWYAhJkpe2gscG6IgM20TZzU1rjmtYPaqtS5380cXRB7zg5CHhX6uNeVyMOaYdH7lXNRJgXr7YKjiOcwIUyFpaBmUuFeBHWHWJYzNOilNtyw=
X-MS-TrafficTypeDiagnostic: DM5PR03MB2635:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2635;20:rYNXqBO9/zfh4dxvP+ENZV4TJE2SsbkCNSfyes5fQE86wrDpW1GV/FlUxROHCJKibHP1mRoTuPqcSmXv3RXQZ1jgn5NUYEl3QncjRtxQhYymUdOwLOUtgsyy5l+OP61mNCXRG0Fq7bD4PhCYOZpiD1vA7b5zTriNABMK7UmrS4vvfWQnl2Co7x5E1tAhkXgYFtA0Rsria7CB5w5TAlYy+vcqA49RqNwpoAuiiC1F7RPgyWpTxv8jsVCHzDJbqhNLJ0sinYK+U7H5R+G9kD4DgSkkCdvgBWQQwl2/N8qDWDKrmRmxDsGEcnAeVEveDRv7RsLk31T+ZxrbwtkO+YnjMGaInG2GsXE3JOsOhIOJcqjYUPjl/BZbrnrzxLldG2fIOaGl4wWzL0pNzJeBBnOHXeKQf14wppKPBlU31szLuCiEgh/KuZI7HBIJAIgLWM64lXQqux7aPToMt7WexYsaJXZ4rFF4k0WxQ9fP2wjv+lfugbcTtCSQqI2yvP2EQVMu;4:eoe6B+RyrZaj6K+ERheSmtFRtsH9LCOZqdG/GZLtZZv/Xj1W3xByoInhN644J3k7HbttOIibq45l0ojD/x0klcX/WuRl217Z6dNiv8h9wh+MUBNC9063QNVD6CQjVWiXzaf8chkjzJtviQ6oM3xvlTXZle7WyXGKto2it8V7yG2K9ogplXGO5Et/hKinnSKld1ndISBRzuYQaVlJu8vtkfNLSGkCV0EniB589YJ8rinj1NNvC1hrdk47r3/5MBeZJVzrotx6zUMDgUuZJoaeAg==
X-Microsoft-Antispam-PRVS: <DM5PR03MB26358B07EA25E9C3C21FA8C9ED930@DM5PR03MB2635.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR03MB2635;BCL:0;PCL:0;RULEID:;SRVR:DM5PR03MB2635;
X-Forefront-PRVS: 0673F5BE31
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(39860400002)(376002)(346002)(366004)(396003)(199004)(189003)(386003)(6506007)(97736004)(59450400001)(6116002)(230700001)(7696005)(53936002)(55016002)(47776003)(316002)(110136005)(9686003)(23726003)(72206003)(33896004)(476003)(3846002)(1076002)(52116002)(956004)(478600001)(1857600001)(86362001)(26005)(16526019)(486006)(186003)(81166006)(81156014)(7736002)(8676002)(8936002)(2906002)(6666003)(4326008)(106356001)(25786009)(5660300001)(39060400002)(68736007)(66066001)(50466002)(50226002)(305945005)(105586002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB2635;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR03MB2635;23:m3vZ6FXpFeDCuMBqpzPd42GBGj9smwrVy5WOetPCJ?=
 =?us-ascii?Q?udjkPQoC9WqsnJnwnzgBrzC9QFdtUNDfaWzcWUsVKDwJtZ2D259Irlaxz8k0?=
 =?us-ascii?Q?/Mh/RIfTsBNoLsMRA06Wf9YT0upS0c92JzVykr1klMkRfAD07cyRfR6EdUoF?=
 =?us-ascii?Q?sBE/LSLq2PGf20nKUKUbcGVOOlCbl3UV9YKix+n9H0FntqFDitCJiuA5MV7F?=
 =?us-ascii?Q?Ev1hqkN617OXCtJ22JSkJrnA2FuYlzWyVMgrnxDoPBOeWO2RZ8aUiWRpExpS?=
 =?us-ascii?Q?uBrmZfEy6WMWTGnskqqWoymm5i29CaZuSKrtu/974lkNPUDtYVYYXYM6Y9SJ?=
 =?us-ascii?Q?VInRWkNUHSo3mPKZcP7oQGiVANpTDHJLakvEIgzTTfZAxqQYmsv2/4XEvQPY?=
 =?us-ascii?Q?xIEU3/TYXgdnUEQ49cfWVZQUVwbrRHo63YvwtfsVglj5syR3xcsfLutbvJpg?=
 =?us-ascii?Q?nbSmojWwXSebL2QYibbSR8DM4JMRLV5ZTPFANeVuwiWaGfT/zK3bLiqzNT5v?=
 =?us-ascii?Q?s+NaWjx2nDVRknluGwqM9eOXOJHus+obnVg7imyBgg3VRPE1Z9K/iy+Stblw?=
 =?us-ascii?Q?8rgmog3gtLgMD0P2YVy0myvH4UbJfFwIXApDSpmF3RIAYNICrZ1QA/5SiQa4?=
 =?us-ascii?Q?1AnE/KF8O79Cs4RHCtC1L4NYhWxLqZaQWNkAmZUIIxmF2lVmhNujc/zJ+rJg?=
 =?us-ascii?Q?NmLzHi2GqML42wui3SA4MRSVdpBaqXDwAMYI8/oN8CMcFmyz0Brc/QHJtJ8c?=
 =?us-ascii?Q?oIiucDjuF2Ey7+2kpqEx9WGRkqnk/6KTtjSLG2oVeOvvXxKAhK3F9cfw27IJ?=
 =?us-ascii?Q?iluC3h2mi0hgJX/LDvMsgfyjNtUJ0TO+KiX+L1puxpxCijAaWt27xtgMRlg1?=
 =?us-ascii?Q?7+q8yRniyfR3HhCwiP4XKPOpLXmEIh1wMD3XazLBVIxlIjQmpJFUJw0uUNoR?=
 =?us-ascii?Q?vBzWEMXJ8INCnH7ho0yiGpd6w8a6glM1/+I1pHDx5AehLS6v+cH8tef1L+yl?=
 =?us-ascii?Q?0pHoHieuo6L+bJBWcBlf0JQYv08NdTZnjd9axrOb6CxS4cyLIize9ZpoXicK?=
 =?us-ascii?Q?G3BimI/pQO0k2kjuFg6E0G4aYHn5dBQllszspKsf2XVJjuhu37qq8eDo9pk8?=
 =?us-ascii?Q?DEQp+ljLvLnXahPL9nrSRUFt0XA+5AIOxDhXBcsB18Mr28DmmL9kldg970Fy?=
 =?us-ascii?Q?ij+t9vznq5kUUR1FYSDpogwagM7yEHCwmviIFzlVdjcnBnpFXHJEyeoXFbQQ?=
 =?us-ascii?Q?z7cKsJSZ6khE6wI0+0=3D?=
X-Microsoft-Antispam-Message-Info: 25n1Hj0jfmzXWu8ukNdPyiI+0dYNanLVddlYoWqkqOYRm5bxshGbzaALrVowrSLr1ivS/WxTtyNHoS/inHAxdzT1SsnIdSA6HwCWq0YH2EXN74zQKc70HE57X4OQGGMpn11BuLMfGEim8xNcAE+QqcrwcJmvNdsOkpZm2c1CM23ofQyhBIc6cR+cDBEtpoxm
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2635;6:YllaVNPvKpYE0u21tZCK03gOGEbt2aIxzzzeSeCywlqDSDxP/EbpG2vG9UAN3jUxDzBP8ssUzBcQVvHtuxYEjKKXAKy2UcHAtwpeto5ZBpXwvHq6tqAT7bGhIWenngO09R1RAQkHedHoD5WqQBx3bihnwTxJHFTaXKryJf1SN4hoZ4ExgFUfHQha/dgB6If2KS+pCPic7LU4gRwzZhu3l7Iuwr4y9duPNSIMuRYdU2gVwRw1XzvsG6y+3h0oJe2VLhulv5xVIE8MIn0cgqyjNeK042koGM5KdQTTtY1y0bPmrB6wVBVVNJbLovyRLYSTNg2yFoongAaW9/P5k8CGtmSYruFOvpT3k/g69JpJApuB2Hdx+DjkBjvjKPL9QPehX0vQft0If9EuF4eovKu6/oLFvDnFGjYJA1l11I/avJK7v96I6jaws8OhRBGtQRylpKXejVztnnr68bNOg8kwxg==;5:G6hp7RLf5DkvOeQgoty+0kHq952K61lePw8+6AYa+YctsOLQaRXfZ73PhLa/6EJzocYMwnfCPjdAYMWk1xCQb0SnhqDz5oNVJX36/VnUmYM1JOVV9HtyAiEzxdwOe9YnwDWFr5GtdrMq3Z6GyuwecJHnw0xMC0S+m9sfr4sirPw=;24:tS53ifbSXrZr5kXqIo/fIUaj8UJJLdxXOQXZB/om9CYSN5l3QOP0jGk8HuxaiXqxgKoLZ4qIHvAGKPppJwv//Q69hLv0Q78A6KpMa2ZzQD0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2635;7:0UW5GC6hEoAhkTvsub7qiZ9rQUIAHnxlD/bt/Zp1O+4vY9Ou4uXXYoV5WY7EWYkiFEDx52O2yXxawmDHAWtbpRvfqpVH9qjKKrImtLop+JJusrThTNs/7cPp35HRmKJGpltoNjXJ8c6N7qZs/JxI+zY7TUkDC/Du7apWND3ie4C7jh6Hfa/NBXA/JTYX5YzodDf10ZG0R49Gzy7gLE4N6jKWz08ORUkqwxikMSwi0tkmTGNnERwcwLSO429j70Lj
X-MS-Office365-Filtering-Correlation-Id: 849316ef-fff3-4b0e-0d82-08d5ba440c3e
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2018 09:12:55.0916 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 849316ef-fff3-4b0e-0d82-08d5ba440c3e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB2635
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix below warning about PPI interrupts configuration:
"GIC: PPI13 is secure or misconfigured"

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 arch/arm/boot/dts/berlin2.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/berlin2.dtsi b/arch/arm/boot/dts/berlin2.dtsi
index d575823c5750..787a9d042ad9 100644
--- a/arch/arm/boot/dts/berlin2.dtsi
+++ b/arch/arm/boot/dts/berlin2.dtsi
@@ -149,7 +149,7 @@
 		local-timer@ad0600 {
 			compatible = "arm,cortex-a9-twd-timer";
 			reg = <0xad0600 0x20>;
-			interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
+			interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_EDGE_RISING)>;
 			clocks = <&chip_clk CLKID_TWD>;
 		};
 
-- 
2.17.0
