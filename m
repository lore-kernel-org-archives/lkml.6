Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3667791-1525410088-2-683470977414714587
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='name', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525410087; b=DLuTi0jczv9K8L9oWt6tJlqkzNIDcq8J9gulJMWJj0W8dt+LSB
    OuXMyZyUOjIiQTtOOrkUXdAvSxMoKRRK4BKve0D1+SZw9mMTG+ESfQAin9BxRDwT
    5bGJrT0/GT5GuYpCR081X0MvNmeIziera7pJFraylj4bbU0gE9sDk426bZa2mzhM
    Cw/tGE5eMFX3Qo1K1WK/MwpTvmT7laqVo/7AzQPmwVUum8B60qbmHbxGJcs1tKcl
    W3PItk+CGYc6ZJdj/fVm+t9mygxlucL+y71OVWLjahDGLm/oXHEIkMCZLZ7ENJVz
    a4fQ1ZzrsQUYVgpfkk6fx7n5wkAzLntmz3/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:date:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525410087; bh=paMvj
    +roOCZjr8wT1lhFUZsIMLQYHBrKfmeRJNWO55o=; b=c3lP4xdju927eXx36YCZJ
    9QOyBbLqt6QbZLr71m7tU6TEKAm71CobB0IxLxc+1oFzYRijNced4GPOViKIxvlo
    GvrU3+h2YuI7zH7u+lCZOc0cBgvoxt64sJbOspdsWLVBL6BS+gRzpLsitOSjMVcq
    lVwMFPOd7VP7O4rqORDzJOYFL3rLaWrhEL1+5b5VWEPM4gRcaQErbaIevtpIjmAb
    XK+7fkm/YMZkwvA6Q9acoeLwBs9q0vkuBY770+hPENwtH+ew25JLAl9hNv0cH+oI
    zWDyYg5vv81Mjpd1AvuXAbzXhw57Cj4rZnvq7fh0KPcVIKPuCuEftx7bYjw7s5hb
    w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=brown.name;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=brown.name header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=brown.name;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=brown.name header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFEcClQfWvodX98JOaTayg9qI4/zOtpN20RHCHEBWA0L9Bg/g4Njq1JJt5dxKHiKQ0Z06ly/3rh8rhvxZaCUYeVXf3k0NhLGLQ+NETI4xYNl+CgTgZZj
    l2nwQ18zuH72On9Ijtm8mU2bZvsO+NHHkHARk9NRVMEMx3L5sU/ZO+nUK3NzO5haxVmGypni12vL4icGn5aVHbWDO4VgvHGQFQDiGDRaD4UL1j4QRgnppIg3
    y1AluXYpX1+4BpyT/ScDAg==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=MKtGQD3n3ToA:10
    a=VUJBJC2UJ8kA:10 a=qEKT6kP3PEYA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=ZZnuYtJkoWoA:10 a=DDOyTI_5AAAA:8 a=NMLta8Nv_mvncLO5eqIA:9
    a=ErQbT7Bm0d_V824g:21 a=CHrblZp3uh00Wawv:21 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: NeilBrown <neil@brown.name>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Fri, 04 May 2018 14:58:36 +1000
Subject: [PATCH 5/8] staging: mt7621-pci: remove conditional compilation.
Message-ID: <152540991621.12190.6675575734267248366.stgit@noble>
In-Reply-To: <152540982998.12190.15220622955317261586.stgit@noble>
References: <152540982998.12190.15220622955317261586.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Code currently defines:

#define CONFIG_PCIE_PORT0
#define CONFIG_PCIE_PORT1
#define CONFIG_PCIE_PORT2
#define GPIO_PERST

and then compiles code only if they are defined.
We might want to disable some of these via devicetree one
day, but for now just remove the #defines and the
conditions - all the code for different ports is
easy to identify.

Signed-off-by: NeilBrown <neil@brown.name>
---
 drivers/staging/mt7621-pci/pci-mt7621.c |   70 +++++++------------------------
 1 file changed, 15 insertions(+), 55 deletions(-)

diff --git a/drivers/staging/mt7621-pci/pci-mt7621.c b/drivers/staging/mt7621-pci/pci-mt7621.c
index c8d7b47c8952..616960e01052 100644
--- a/drivers/staging/mt7621-pci/pci-mt7621.c
+++ b/drivers/staging/mt7621-pci/pci-mt7621.c
@@ -64,9 +64,6 @@ extern void chk_phy_pll(void);
  * devices.
  */
 
-#define CONFIG_PCIE_PORT0
-#define CONFIG_PCIE_PORT1
-#define CONFIG_PCIE_PORT2
 #define RALINK_PCIE0_CLK_EN		(1<<24)
 #define RALINK_PCIE1_CLK_EN		(1<<25)
 #define RALINK_PCIE2_CLK_EN		(1<<26)
@@ -140,7 +137,7 @@ extern void chk_phy_pll(void);
 #define RALINK_PCI_IO_MAP_BASE		0x1e160000
 
 #define RALINK_SYSTEM_CONTROL_BASE	0xbe000000
-#define GPIO_PERST
+
 #define ASSERT_SYSRST_PCIE(val)		\
 	do {								\
 		if (*(unsigned int *)(0xbe00000c) == 0x00030101)	\
@@ -392,21 +389,15 @@ set_pcie_phy(u32 *addr, int start_b, int bits, int val)
 void
 bypass_pipe_rst(void)
 {
-#if defined (CONFIG_PCIE_PORT0)
 	/* PCIe Port 0 */
 	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x02c), 12, 1, 0x01);	// rg_pe1_pipe_rst_b
 	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x02c),  4, 1, 0x01);	// rg_pe1_pipe_cmd_frc[4]
-#endif
-#if defined (CONFIG_PCIE_PORT1)
 	/* PCIe Port 1 */
 	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x12c), 12, 1, 0x01);	// rg_pe1_pipe_rst_b
 	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x12c),  4, 1, 0x01);	// rg_pe1_pipe_cmd_frc[4]
-#endif
-#if defined (CONFIG_PCIE_PORT2)
 	/* PCIe Port 2 */
 	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x02c), 12, 1, 0x01);	// rg_pe1_pipe_rst_b
 	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x02c),  4, 1, 0x01);	// rg_pe1_pipe_cmd_frc[4]
-#endif
 }
 
 void
@@ -415,7 +406,6 @@ set_phy_for_ssc(void)
 	unsigned long reg = (*(volatile u32 *)(RALINK_SYSCTL_BASE + 0x10));
 
 	reg = (reg >> 6) & 0x7;
-#if defined (CONFIG_PCIE_PORT0) || defined (CONFIG_PCIE_PORT1)
 	/* Set PCIe Port0 & Port1 PHY to disable SSC */
 	/* Debug Xtal Type */
 	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x400),  8, 1, 0x01);	// rg_pe1_frc_h_xtal_type
@@ -456,8 +446,7 @@ set_phy_for_ssc(void)
 	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x100),  5, 1, 0x01);	// rg_pe1_phy_en	//Port 1 enable
 	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x000),  4, 1, 0x00);	// rg_pe1_frc_phy_en	//Force Port 0 disable control
 	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P0P1_CTL_OFFSET + 0x100),  4, 1, 0x00);	// rg_pe1_frc_phy_en	//Force Port 1 disable control
-#endif
-#if defined (CONFIG_PCIE_PORT2)
+
 	/* Set PCIe Port2 PHY to disable SSC */
 	/* Debug Xtal Type */
 	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x400),  8, 1, 0x01);	// rg_pe1_frc_h_xtal_type
@@ -490,7 +479,6 @@ set_phy_for_ssc(void)
 	/* Enable PHY and disable force mode */
 	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x000),  5, 1, 0x01);	// rg_pe1_phy_en	//Port 0 enable
 	set_pcie_phy((u32 *)(RALINK_PCIEPHY_P2_CTL_OFFSET + 0x000),  4, 1, 0x00);	// rg_pe1_frc_phy_en	//Force Port 0 disable control
-#endif
 }
 
 void setup_cm_memory_region(struct resource *mem_resource)
@@ -519,18 +507,13 @@ static int mt7621_pci_probe(struct platform_device *pdev)
 	ioport_resource.start= 0;
 	ioport_resource.end = ~0;
 
-#if defined (CONFIG_PCIE_PORT0)
 	val = RALINK_PCIE0_RST;
-#endif
-#if defined (CONFIG_PCIE_PORT1)
 	val |= RALINK_PCIE1_RST;
-#endif
-#if defined (CONFIG_PCIE_PORT2)
 	val |= RALINK_PCIE2_RST;
-#endif
+
 	ASSERT_SYSRST_PCIE(RALINK_PCIE0_RST | RALINK_PCIE1_RST | RALINK_PCIE2_RST);
 	printk("pull PCIe RST: RALINK_RSTCTRL = %x\n", RALINK_RSTCTRL);
-#if defined GPIO_PERST /* add GPIO control instead of PERST_N */ /*chhung*/
+
 	*(unsigned int *)(0xbe000060) &= ~(0x3<<10 | 0x3<<3);
 	*(unsigned int *)(0xbe000060) |= 0x1<<10 | 0x1<<3;
 	mdelay(100);
@@ -539,18 +522,11 @@ static int mt7621_pci_probe(struct platform_device *pdev)
 	*(unsigned int *)(0xbe000620) &= ~(0x1<<19 | 0x1<<8 | 0x1<<7);		// clear DATA
 
 	mdelay(100);
-#else
-	*(unsigned int *)(0xbe000060) &= ~0x00000c00;
-#endif
-#if defined (CONFIG_PCIE_PORT0)
+
 	val = RALINK_PCIE0_RST;
-#endif
-#if defined (CONFIG_PCIE_PORT1)
 	val |= RALINK_PCIE1_RST;
-#endif
-#if defined (CONFIG_PCIE_PORT2)
 	val |= RALINK_PCIE2_RST;
-#endif
+
 	DEASSERT_SYSRST_PCIE(val);
 	printk("release PCIe RST: RALINK_RSTCTRL = %x\n", RALINK_RSTCTRL);
 
@@ -559,18 +535,14 @@ static int mt7621_pci_probe(struct platform_device *pdev)
 	set_phy_for_ssc();
 	printk("release PCIe RST: RALINK_RSTCTRL = %x\n", RALINK_RSTCTRL);
 
-#if defined (CONFIG_PCIE_PORT0)
 	read_config(0, 0, 0, 0x70c, &val);
 	printk("Port 0 N_FTS = %x\n", (unsigned int)val);
-#endif
-#if defined (CONFIG_PCIE_PORT1)
+
 	read_config(0, 1, 0, 0x70c, &val);
 	printk("Port 1 N_FTS = %x\n", (unsigned int)val);
-#endif
-#if defined (CONFIG_PCIE_PORT2)
+
 	read_config(0, 2, 0, 0x70c, &val);
 	printk("Port 2 N_FTS = %x\n", (unsigned int)val);
-#endif
 
 	RALINK_RSTCTRL = (RALINK_RSTCTRL | RALINK_PCIE_RST);
 	RALINK_SYSCFG1 &= ~(0x30);
@@ -582,16 +554,10 @@ static int mt7621_pci_probe(struct platform_device *pdev)
 	mdelay(50);
 	RALINK_RSTCTRL = (RALINK_RSTCTRL & ~RALINK_PCIE_RST);
 
-#if defined GPIO_PERST /* add GPIO control instead of PERST_N */  /*chhung*/
+	/* Use GPIO control instead of PERST_N */
 	*(unsigned int *)(0xbe000620) |= 0x1<<19 | 0x1<<8 | 0x1<<7;		// set DATA
-	mdelay(100);
-#else
-	RALINK_PCI_PCICFG_ADDR &= ~(1<<1); //de-assert PERST
-#endif
-	mdelay(500);
+	mdelay(1000);
 
-	mdelay(500);
-#if defined (CONFIG_PCIE_PORT0)
 	if(( RALINK_PCI0_STATUS & 0x1) == 0)
 	{
 		printk("PCIE0 no card, disable it(RST&CLK)\n");
@@ -602,8 +568,7 @@ static int mt7621_pci_probe(struct platform_device *pdev)
 		pcie_link_status |= 1<<0;
 		RALINK_PCI_PCIMSK_ADDR |= (1<<20); // enable pcie1 interrupt
 	}
-#endif
-#if defined (CONFIG_PCIE_PORT1)
+
 	if(( RALINK_PCI1_STATUS & 0x1) == 0)
 	{
 		printk("PCIE1 no card, disable it(RST&CLK)\n");
@@ -614,8 +579,7 @@ static int mt7621_pci_probe(struct platform_device *pdev)
 		pcie_link_status |= 1<<1;
 		RALINK_PCI_PCIMSK_ADDR |= (1<<21); // enable pcie1 interrupt
 	}
-#endif
-#if defined (CONFIG_PCIE_PORT2)
+
 	if (( RALINK_PCI2_STATUS & 0x1) == 0) {
 		printk("PCIE2 no card, disable it(RST&CLK)\n");
 		ASSERT_SYSRST_PCIE(RALINK_PCIE2_RST);
@@ -625,7 +589,7 @@ static int mt7621_pci_probe(struct platform_device *pdev)
 		pcie_link_status |= 1<<2;
 		RALINK_PCI_PCIMSK_ADDR |= (1<<22); // enable pcie2 interrupt
 	}
-#endif
+
 	if (pcie_link_status == 0)
 		return 0;
 
@@ -676,7 +640,6 @@ pcie(2/1/0) link status	pcie2_num	pcie1_num	pcie0_num
 	RALINK_PCI_MEMBASE = 0xffffffff; //RALINK_PCI_MM_MAP_BASE;
 	RALINK_PCI_IOBASE = RALINK_PCI_IO_MAP_BASE;
 
-#if defined (CONFIG_PCIE_PORT0)
 	//PCIe0
 	if((pcie_link_status & 0x1) != 0) {
 		RALINK_PCI0_BAR0SETUP_ADDR = 0x7FFF0001;	//open 7FFF:2G; ENABLE
@@ -684,8 +647,7 @@ pcie(2/1/0) link status	pcie2_num	pcie1_num	pcie0_num
 		RALINK_PCI0_CLASS = 0x06040001;
 		printk("PCIE0 enabled\n");
 	}
-#endif
-#if defined (CONFIG_PCIE_PORT1)
+
 	//PCIe1
 	if ((pcie_link_status & 0x2) != 0) {
 		RALINK_PCI1_BAR0SETUP_ADDR = 0x7FFF0001;	//open 7FFF:2G; ENABLE
@@ -693,8 +655,7 @@ pcie(2/1/0) link status	pcie2_num	pcie1_num	pcie0_num
 		RALINK_PCI1_CLASS = 0x06040001;
 		printk("PCIE1 enabled\n");
 	}
-#endif
-#if defined (CONFIG_PCIE_PORT2)
+
 	//PCIe2
 	if ((pcie_link_status & 0x4) != 0) {
 		RALINK_PCI2_BAR0SETUP_ADDR = 0x7FFF0001;	//open 7FFF:2G; ENABLE
@@ -702,7 +663,6 @@ pcie(2/1/0) link status	pcie2_num	pcie1_num	pcie0_num
 		RALINK_PCI2_CLASS = 0x06040001;
 		printk("PCIE2 enabled\n");
 	}
-#endif
 
 	switch(pcie_link_status) {
 	case 7:


_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
