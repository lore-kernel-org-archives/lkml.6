Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70EE3ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 13:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2032C208B1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 13:41:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2032C208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730822AbeGMN40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 09:56:26 -0400
Received: from mout.web.de ([212.227.17.12]:36811 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729284AbeGMN4Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 09:56:25 -0400
Received: from lab-pc04.sra.uni-hannover.de ([130.75.33.87]) by smtp.web.de
 (mrweb101 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0M2dTd-1fwsa838BJ-00sKbx; Fri, 13 Jul 2018 15:41:17 +0200
From:   =?UTF-8?q?Oliver=20H=C3=BCbers?= <oliver.huebers@web.de>
To:     gregkh@linuxfoundation.org
Cc:     matthias.bgg@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@i4.cs.fau.de,
        Vanessa Borgmann <nessa.x@web.de>,
        =?UTF-8?q?Oliver=20H=C3=BCbers?= <oliver.huebers@web.de>
Subject: [PATCH 2/4] staging: mt7621-pci: Fix coding style issues reported by checkpatch
Date:   Fri, 13 Jul 2018 15:41:04 +0200
Message-Id: <1531489266-20410-2-git-send-email-oliver.huebers@web.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531489266-20410-1-git-send-email-oliver.huebers@web.de>
References: <1531489266-20410-1-git-send-email-oliver.huebers@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:W1CZWEiXj8k1NU5kVPXdzNGBNqag3AaAbNxnxN72TYEFhXr1i0W
 jiIpfTa8gqseSIL1V7xLHpbBQZi0kq2ihiLZspk8QWpS1VPK973FEln7bTSR5FIiOePyXHI
 gSsZswP+3pH9w3u0Kb6Mi2YJcDYYTJxvnEafxaQARRAWdeSGkyIL/zqluk0JwK7l5GHmoC4
 AItAhfXuWWES+yDDBfFvw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TpnMC4hhx1c=:uQWDnhkBWO7jeuznFW0B1w
 iuiEfzhaPJTcevtFcuuliPe45QDtmxxjqh9zWul0UjsPhml7WXTECKjOFCxqghbZRqY3xl07y
 u5vCn681oTS08OmrxtM0Qb6xlz7AnBJ0FmM1STftK/CCAU1Ebh/ezs4BOAACsDL7mYcHJsof9
 KTHg6CU9eXbDRz3ygTjZNNF3tzRMlukxz2UW8Qd536Ave8cV8qf/F4CQv/Bmhx4jj+1/5stqU
 0GX4eo0tZ7J7mizrghyBQkHnYDsvUi9ZuPwp9p/wW+1nFY3THX67mZ2Hjkqn1SXMJ3/zbqX0e
 tdjP45rFNq7pPd+1Dnt9M60gyeJVdw1gCVgNQ0DtidbKnKzJ1on11lUPQEzUv62+X3FvEeR4q
 RjidIvQ1ewhEKWthyn0kkZ/R0ChdgJVkp0zdcwKpiYmNqHNOa+RME1U6MXRP8GIVsB8AZ3ZqH
 hC4hWDGx96es3phQ+rYadtuKuqg45bNbHrCpsbnBb4YQQsSLdtm/cGbTOcDHG0E/7UcyhBxOt
 E69OiXviuLHwqe9GgD926n3goRG1st3aeFWBEa2FJm38XMLObS/olj9ikLPoP0juFgELQ21ye
 V/gt0pn3sIYnOBR6ae/g2iNVsw8HGYA70j9SVbsimHgKkskL/8hEkxdNtQndcVF55FQiYbsLl
 1/vkPVShGTNYHG9qwRlJeGmn84b8KgchLdCOaNd3VPkEKkRd4y78tzU6tN3cMq3FgnhxjQ7VP
 w04bKOD5ADLgxOYY2Z/EIGYz18AFUWAoBmRpkBvstbmLrQkA/Bm0fBGvyaL+tXL2lp/s4eSM/
 Ounl5FA
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vanessa Borgmann <nessa.x@web.de>

Fix errors: space errors, braces
Fix warnings: comment warnings

Signed-off-by: Oliver Hübers <oliver.huebers@web.de>
Signed-off-by: Vanessa Borgmann <nessa.x@web.de>
---
 drivers/staging/mt7621-pci/pci-mt7621.c | 230 ++++++++++++++++----------------
 1 file changed, 112 insertions(+), 118 deletions(-)

diff --git a/drivers/staging/mt7621-pci/pci-mt7621.c b/drivers/staging/mt7621-pci/pci-mt7621.c
index e092b5d..d0d3fb9 100644
--- a/drivers/staging/mt7621-pci/pci-mt7621.c
+++ b/drivers/staging/mt7621-pci/pci-mt7621.c
@@ -21,11 +21,6 @@
  *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
  *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- *
- *
  **************************************************************************
  * May 2007 Bruce Chang
  * Initial Release
@@ -62,20 +57,20 @@
  * devices.
  */
 
-#define RALINK_PCIE0_CLK_EN		(1<<24)
-#define RALINK_PCIE1_CLK_EN		(1<<25)
-#define RALINK_PCIE2_CLK_EN		(1<<26)
+#define RALINK_PCIE0_CLK_EN		(1 << 24)
+#define RALINK_PCIE1_CLK_EN		(1 << 25)
+#define RALINK_PCIE2_CLK_EN		(1 << 26)
 
 #define RALINK_PCI_CONFIG_ADDR		0x20
 #define RALINK_PCI_CONFIG_DATA_VIRTUAL_REG	0x24
-#define RALINK_PCI_MEMBASE		*(volatile u32 *)(RALINK_PCI_BASE + 0x0028)
-#define RALINK_PCI_IOBASE		*(volatile u32 *)(RALINK_PCI_BASE + 0x002C)
-#define RALINK_PCIE0_RST		(1<<24)
-#define RALINK_PCIE1_RST		(1<<25)
-#define RALINK_PCIE2_RST		(1<<26)
-
-#define RALINK_PCI_PCICFG_ADDR		*(volatile u32 *)(RALINK_PCI_BASE + 0x0000)
-#define RALINK_PCI_PCIMSK_ADDR		*(volatile u32 *)(RALINK_PCI_BASE + 0x000C)
+#define RALINK_PCI_MEMBASE		(*(volatile u32 *)(RALINK_PCI_BASE + 0x0028))
+#define RALINK_PCI_IOBASE		(*(volatile u32 *)(RALINK_PCI_BASE + 0x002C))
+#define RALINK_PCIE0_RST		(1 << 24)
+#define RALINK_PCIE1_RST		(1 << 25)
+#define RALINK_PCIE2_RST		(1 << 26)
+
+#define RALINK_PCI_PCICFG_ADDR		(*(volatile u32 *)(RALINK_PCI_BASE + 0x0000))
+#define RALINK_PCI_PCIMSK_ADDR		(*(volatile u32 *)(RALINK_PCI_BASE + 0x000C))
 #define RALINK_PCI_BASE	0xBE140000
 
 #define RALINK_PCIEPHY_P0P1_CTL_OFFSET	(RALINK_PCI_BASE + 0x9000)
@@ -83,49 +78,49 @@
 #define RT6855_PCIE1_OFFSET		0x3000
 #define RT6855_PCIE2_OFFSET		0x4000
 
-#define RALINK_PCI0_BAR0SETUP_ADDR	*(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE0_OFFSET + 0x0010)
-#define RALINK_PCI0_IMBASEBAR0_ADDR	*(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE0_OFFSET + 0x0018)
-#define RALINK_PCI0_ID			*(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE0_OFFSET + 0x0030)
-#define RALINK_PCI0_CLASS		*(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE0_OFFSET + 0x0034)
-#define RALINK_PCI0_SUBID		*(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE0_OFFSET + 0x0038)
-#define RALINK_PCI0_STATUS		*(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE0_OFFSET + 0x0050)
-#define RALINK_PCI0_DERR		*(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE0_OFFSET + 0x0060)
-#define RALINK_PCI0_ECRC		*(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE0_OFFSET + 0x0064)
-
-#define RALINK_PCI1_BAR0SETUP_ADDR	*(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE1_OFFSET + 0x0010)
-#define RALINK_PCI1_IMBASEBAR0_ADDR	*(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE1_OFFSET + 0x0018)
-#define RALINK_PCI1_ID			*(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE1_OFFSET + 0x0030)
-#define RALINK_PCI1_CLASS		*(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE1_OFFSET + 0x0034)
-#define RALINK_PCI1_SUBID		*(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE1_OFFSET + 0x0038)
-#define RALINK_PCI1_STATUS		*(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE1_OFFSET + 0x0050)
-#define RALINK_PCI1_DERR		*(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE1_OFFSET + 0x0060)
-#define RALINK_PCI1_ECRC		*(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE1_OFFSET + 0x0064)
-
-#define RALINK_PCI2_BAR0SETUP_ADDR	*(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE2_OFFSET + 0x0010)
-#define RALINK_PCI2_IMBASEBAR0_ADDR	*(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE2_OFFSET + 0x0018)
-#define RALINK_PCI2_ID			*(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE2_OFFSET + 0x0030)
-#define RALINK_PCI2_CLASS		*(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE2_OFFSET + 0x0034)
-#define RALINK_PCI2_SUBID		*(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE2_OFFSET + 0x0038)
-#define RALINK_PCI2_STATUS		*(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE2_OFFSET + 0x0050)
-#define RALINK_PCI2_DERR		*(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE2_OFFSET + 0x0060)
-#define RALINK_PCI2_ECRC		*(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE2_OFFSET + 0x0064)
+#define RALINK_PCI0_BAR0SETUP_ADDR	(*(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE0_OFFSET + 0x0010))
+#define RALINK_PCI0_IMBASEBAR0_ADDR	(*(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE0_OFFSET + 0x0018))
+#define RALINK_PCI0_ID			(*(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE0_OFFSET + 0x0030))
+#define RALINK_PCI0_CLASS		(*(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE0_OFFSET + 0x0034))
+#define RALINK_PCI0_SUBID		(*(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE0_OFFSET + 0x0038))
+#define RALINK_PCI0_STATUS		(*(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE0_OFFSET + 0x0050))
+#define RALINK_PCI0_DERR		(*(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE0_OFFSET + 0x0060))
+#define RALINK_PCI0_ECRC		(*(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE0_OFFSET + 0x0064))
+
+#define RALINK_PCI1_BAR0SETUP_ADDR	(*(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE1_OFFSET + 0x0010))
+#define RALINK_PCI1_IMBASEBAR0_ADDR	(*(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE1_OFFSET + 0x0018))
+#define RALINK_PCI1_ID			(*(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE1_OFFSET + 0x0030))
+#define RALINK_PCI1_CLASS		(*(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE1_OFFSET + 0x0034))
+#define RALINK_PCI1_SUBID		(*(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE1_OFFSET + 0x0038))
+#define RALINK_PCI1_STATUS		(*(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE1_OFFSET + 0x0050))
+#define RALINK_PCI1_DERR		(*(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE1_OFFSET + 0x0060))
+#define RALINK_PCI1_ECRC		(*(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE1_OFFSET + 0x0064))
+
+#define RALINK_PCI2_BAR0SETUP_ADDR	(*(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE2_OFFSET + 0x0010))
+#define RALINK_PCI2_IMBASEBAR0_ADDR	(*(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE2_OFFSET + 0x0018))
+#define RALINK_PCI2_ID			(*(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE2_OFFSET + 0x0030))
+#define RALINK_PCI2_CLASS		(*(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE2_OFFSET + 0x0034))
+#define RALINK_PCI2_SUBID		(*(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE2_OFFSET + 0x0038))
+#define RALINK_PCI2_STATUS		(*(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE2_OFFSET + 0x0050))
+#define RALINK_PCI2_DERR		(*(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE2_OFFSET + 0x0060))
+#define RALINK_PCI2_ECRC		(*(volatile u32 *)(RALINK_PCI_BASE + RT6855_PCIE2_OFFSET + 0x0064))
 
 #define RALINK_PCIEPHY_P0P1_CTL_OFFSET	(RALINK_PCI_BASE + 0x9000)
 #define RALINK_PCIEPHY_P2_CTL_OFFSET	(RALINK_PCI_BASE + 0xA000)
 
 #define MV_WRITE(ofs, data)	\
-	*(volatile u32 *)(RALINK_PCI_BASE+(ofs)) = cpu_to_le32(data)
+	(*(volatile u32 *)(RALINK_PCI_BASE + (ofs)) = cpu_to_le32(data))
 #define MV_READ(ofs, data)	\
-	*(data) = le32_to_cpu(*(volatile u32 *)(RALINK_PCI_BASE+(ofs)))
+	(*(data) = le32_to_cpu(*(volatile u32 *)(RALINK_PCI_BASE + (ofs))))
 #define MV_WRITE_16(ofs, data)	\
-	*(volatile u16 *)(RALINK_PCI_BASE+(ofs)) = cpu_to_le16(data)
+	(*(volatile u16 *)(RALINK_PCI_BASE + (ofs)) = cpu_to_le16(data))
 #define MV_READ_16(ofs, data)	\
-	*(data) = le16_to_cpu(*(volatile u16 *)(RALINK_PCI_BASE+(ofs)))
+	(*(data) = le16_to_cpu(*(volatile u16 *)(RALINK_PCI_BASE + (ofs))))
 
 #define MV_WRITE_8(ofs, data)	\
-	*(volatile u8 *)(RALINK_PCI_BASE+(ofs)) = data
+	(*(volatile u8 *)(RALINK_PCI_BASE + (ofs)) = data)
 #define MV_READ_8(ofs, data)	\
-	*(data) = *(volatile u8 *)(RALINK_PCI_BASE+(ofs))
+	(*(data) = *(volatile u8 *)(RALINK_PCI_BASE + (ofs)))
 
 #define RALINK_PCI_MM_MAP_BASE		0x60000000
 #define RALINK_PCI_IO_MAP_BASE		0x1e160000
@@ -152,23 +147,23 @@
 #define PPLL_CFG1			0x9c
 #define PPLL_DRV			0xa0
 /* SYSC_REG_SYSTEM_CONFIG1 bits */
-#define RALINK_PCI_HOST_MODE_EN		(1<<7)
-#define RALINK_PCIE_RC_MODE_EN		(1<<8)
+#define RALINK_PCI_HOST_MODE_EN		(1 << 7)
+#define RALINK_PCIE_RC_MODE_EN		(1 << 8)
 //RALINK_RSTCTRL bit
-#define RALINK_PCIE_RST			(1<<23)
-#define RALINK_PCI_RST			(1<<24)
+#define RALINK_PCIE_RST			(1 << 23)
+#define RALINK_PCI_RST			(1 << 24)
 //RALINK_CLKCFG1 bit
-#define RALINK_PCI_CLK_EN		(1<<19)
-#define RALINK_PCIE_CLK_EN		(1<<21)
+#define RALINK_PCI_CLK_EN		(1 << 19)
+#define RALINK_PCIE_CLK_EN		(1 << 21)
 //RALINK_GPIOMODE bit
-#define PCI_SLOTx2			(1<<11)
-#define PCI_SLOTx1			(2<<11)
+#define PCI_SLOTx2			(1 << 11)
+#define PCI_SLOTx1			(2 << 11)
 //MTK PCIE PLL bit
-#define PDRV_SW_SET			(1<<31)
-#define LC_CKDRVPD_			(1<<19)
+#define PDRV_SW_SET			(1 << 31)
+#define LC_CKDRVPD_			(1 << 19)
 
 #define MEMORY_BASE 0x0
-static int pcie_link_status = 0;
+static int pcie_link_status;
 
 #define PCI_ACCESS_READ_1  0
 #define PCI_ACCESS_READ_2  1
@@ -185,7 +180,7 @@ static inline u32 mt7621_pci_get_cfgaddr(unsigned int bus, unsigned int slot,
 }
 
 static int config_access(unsigned char access_type, struct pci_bus *bus,
-			unsigned int devfn, unsigned int where, u32 *data)
+			 unsigned int devfn, unsigned int where, u32 *data)
 {
 	unsigned int slot = PCI_SLOT(devfn);
 	u8 func = PCI_FUNC(devfn);
@@ -197,23 +192,21 @@ static int config_access(unsigned char access_type, struct pci_bus *bus,
 
 	address = mt7621_pci_get_cfgaddr(bus->number, slot, func, where);
 
-	MV_WRITE(address_reg, address);
-
 	switch (access_type) {
 	case PCI_ACCESS_WRITE_1:
-		MV_WRITE_8(data_reg+(where&0x3), *data);
+		MV_WRITE_8(data_reg + (where & 0x3), *data);
 		break;
 	case PCI_ACCESS_WRITE_2:
-		MV_WRITE_16(data_reg+(where&0x3), *data);
+		MV_WRITE_16(data_reg + (where & 0x3), *data);
 		break;
 	case PCI_ACCESS_WRITE_4:
 		MV_WRITE(data_reg, *data);
 		break;
 	case PCI_ACCESS_READ_1:
-		MV_READ_8(data_reg+(where&0x3), data);
+		MV_READ_8(data_reg + (where & 0x3), data);
 		break;
 	case PCI_ACCESS_READ_2:
-		MV_READ_16(data_reg+(where&0x3), data);
+		MV_READ_16(data_reg + (where & 0x3), data);
 		break;
 	case PCI_ACCESS_READ_4:
 		MV_READ(data_reg, data);
@@ -275,9 +268,9 @@ pci_config_read(struct pci_bus *bus, unsigned int devfn, int where, int size, u3
 {
 	switch (size) {
 	case 1:
-		return read_config_byte(bus, devfn, where, (u8 *) val);
+	return read_config_byte(bus, devfn, where, (u8 *)val);
 	case 2:
-		return read_config_word(bus, devfn, where, (u16 *) val);
+	return read_config_word(bus, devfn, where, (u16 *)val);
 	default:
 		return read_config_dword(bus, devfn, where, val);
 	}
@@ -288,9 +281,9 @@ pci_config_write(struct pci_bus *bus, unsigned int devfn, int where, int size, u
 {
 	switch (size) {
 	case 1:
-		return write_config_byte(bus, devfn, where, (u8) val);
+		return write_config_byte(bus, devfn, where, (u8)val);
 	case 2:
-		return write_config_word(bus, devfn, where, (u16) val);
+		return write_config_word(bus, devfn, where, (u16)val);
 	default:
 		return write_config_dword(bus, devfn, where, val);
 	}
@@ -319,7 +312,6 @@ read_config(unsigned long bus, unsigned long dev, unsigned long func, unsigned l
 	address = mt7621_pci_get_cfgaddr(bus, dev, func, reg);
 	MV_WRITE(address_reg, address);
 	MV_READ(data_reg, val);
-	return;
 }
 
 static void
@@ -332,7 +324,6 @@ write_config(unsigned long bus, unsigned long dev, unsigned long func, unsigned
 	address = mt7621_pci_get_cfgaddr(bus, dev, func, reg);
 	MV_WRITE(address_reg, address);
 	MV_WRITE(data_reg, val);
-	return;
 }
 
 int
@@ -363,7 +354,7 @@ pcibios_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 void
 set_pcie_phy(u32 *addr, int start_b, int bits, int val)
 {
-	*(unsigned int *)(addr) &= ~(((1<<bits) - 1)<<start_b);
+	*(unsigned int *)(addr) &= ~(((1 << bits) - 1) << start_b);
 	*(unsigned int *)(addr) |= val << start_b;
 }
 
@@ -465,17 +456,20 @@ set_phy_for_ssc(void)
 void setup_cm_memory_region(struct resource *mem_resource)
 {
 	resource_size_t mask;
+
 	if (mips_cps_numiocu(0)) {
-		/* FIXME: hardware doesn't accept mask values with 1s after
-		 * 0s (e.g. 0xffef), so it would be great to warn if that's
-		 * about to happen */
+		/*
+		 *FIXME: hardware doesn't accept mask values with 1s after
+		 *0s (e.g. 0xffef), so it would be great to warn if that's
+		 *about to happen
+		 */
 		mask = ~(mem_resource->end - mem_resource->start);
 
 		write_gcr_reg1_base(mem_resource->start);
 		write_gcr_reg1_mask(mask | CM_GCR_REGn_MASK_CMTGT_IOCU0);
 		printk("PCI coherence region base: 0x%08llx, mask/settings: 0x%08llx\n",
-			(unsigned long long)read_gcr_reg1_base(),
-			(unsigned long long)read_gcr_reg1_mask());
+		       (unsigned long long)read_gcr_reg1_base(),
+		       (unsigned long long)read_gcr_reg1_mask());
 	}
 }
 
@@ -494,12 +488,12 @@ static int mt7621_pci_probe(struct platform_device *pdev)
 
 	ASSERT_SYSRST_PCIE(RALINK_PCIE0_RST | RALINK_PCIE1_RST | RALINK_PCIE2_RST);
 
-	*(unsigned int *)(0xbe000060) &= ~(0x3<<10 | 0x3<<3);
-	*(unsigned int *)(0xbe000060) |= 0x1<<10 | 0x1<<3;
+	*(unsigned int *)(0xbe000060) &= ~(0x3 << 10 | 0x3 << 3);
+	*(unsigned int *)(0xbe000060) |= 0x1 << 10 | 0x1 << 3;
 	mdelay(100);
-	*(unsigned int *)(0xbe000600) |= 0x1<<19 | 0x1<<8 | 0x1<<7; // use GPIO19/GPIO8/GPIO7 (PERST_N/UART_RXD3/UART_TXD3)
+	*(unsigned int *)(0xbe000600) |= 0x1 << 19 | 0x1 << 8 | 0x1 << 7; // use GPIO19/GPIO8/GPIO7 (PERST_N/UART_RXD3/UART_TXD3)
 	mdelay(100);
-	*(unsigned int *)(0xbe000620) &= ~(0x1<<19 | 0x1<<8 | 0x1<<7);		// clear DATA
+	*(unsigned int *)(0xbe000620) &= ~(0x1 << 19 | 0x1 << 8 | 0x1 << 7);		// clear DATA
 
 	mdelay(100);
 
@@ -509,7 +503,7 @@ static int mt7621_pci_probe(struct platform_device *pdev)
 
 	DEASSERT_SYSRST_PCIE(val);
 
-	if ((*(unsigned int *)(0xbe00000c)&0xFFFF) == 0x0101) // MT7621 E2
+	if ((*(unsigned int *)(0xbe00000c) & 0xFFFF) == 0x0101) // MT7621 E2
 		bypass_pipe_rst();
 	set_phy_for_ssc();
 
@@ -533,53 +527,54 @@ static int mt7621_pci_probe(struct platform_device *pdev)
 	rt_sysc_m32(RALINK_PCIE_RST, 0, RALINK_RSTCTRL);
 
 	/* Use GPIO control instead of PERST_N */
-	*(unsigned int *)(0xbe000620) |= 0x1<<19 | 0x1<<8 | 0x1<<7;		// set DATA
+	*(unsigned int *)(0xbe000620) |= 0x1 << 19 | 0x1 << 8 | 0x1 << 7;		// set DATA
 	mdelay(1000);
 
 	if ((RALINK_PCI0_STATUS & 0x1) == 0) {
 		printk("PCIE0 no card, disable it(RST&CLK)\n");
 		ASSERT_SYSRST_PCIE(RALINK_PCIE0_RST);
 		rt_sysc_m32(RALINK_PCIE0_CLK_EN, 0, RALINK_CLKCFG1);
-		pcie_link_status &= ~(1<<0);
+		pcie_link_status &= ~(1 << 0);
 	} else {
-		pcie_link_status |= 1<<0;
-		RALINK_PCI_PCIMSK_ADDR |= (1<<20); // enable pcie1 interrupt
+		pcie_link_status |= 1 << 0;
+		RALINK_PCI_PCIMSK_ADDR |= (1 << 20); // enable pcie1 interrupt
 	}
 
 	if ((RALINK_PCI1_STATUS & 0x1) == 0) {
 		printk("PCIE1 no card, disable it(RST&CLK)\n");
 		ASSERT_SYSRST_PCIE(RALINK_PCIE1_RST);
 		rt_sysc_m32(RALINK_PCIE1_CLK_EN, 0, RALINK_CLKCFG1);
-		pcie_link_status &= ~(1<<1);
+		pcie_link_status &= ~(1 << 1);
 	} else {
-		pcie_link_status |= 1<<1;
-		RALINK_PCI_PCIMSK_ADDR |= (1<<21); // enable pcie1 interrupt
+		pcie_link_status |= 1 << 1;
+		RALINK_PCI_PCIMSK_ADDR |= (1 << 21); // enable pcie1 interrupt
 	}
 
 	if ((RALINK_PCI2_STATUS & 0x1) == 0) {
 		printk("PCIE2 no card, disable it(RST&CLK)\n");
 		ASSERT_SYSRST_PCIE(RALINK_PCIE2_RST);
 		rt_sysc_m32(RALINK_PCIE2_CLK_EN, 0, RALINK_CLKCFG1);
-		pcie_link_status &= ~(1<<2);
+		pcie_link_status &= ~(1 << 2);
 	} else {
-		pcie_link_status |= 1<<2;
-		RALINK_PCI_PCIMSK_ADDR |= (1<<22); // enable pcie2 interrupt
+		pcie_link_status |= 1 << 2;
+		RALINK_PCI_PCIMSK_ADDR |= (1 << 22); // enable pcie2 interrupt
 	}
 
 	if (pcie_link_status == 0)
 		return 0;
 
-/*
-pcie(2/1/0) link status	pcie2_num	pcie1_num	pcie0_num
-3'b000			x		x		x
-3'b001			x		x		0
-3'b010			x		0		x
-3'b011			x		1		0
-3'b100			0		x		x
-3'b101			1		x		0
-3'b110			1		0		x
-3'b111			2		1		0
-*/
+	/*
+	pcie(2/1/0) link status	pcie2_num	pcie1_num	pcie0_num
+	3'b000			x		x		x
+	3'b001			x		x		0
+	3'b010			x		0		x
+	3'b011			x		1		0
+	3'b100			0		x		x
+	3'b101			1		x		0
+	3'b110			1		0		x
+	3'b111			2		1		0
+	*/
+
 	switch (pcie_link_status) {
 	case 2:
 		RALINK_PCI_PCICFG_ADDR &= ~0x00ff0000;
@@ -606,10 +601,10 @@ pcie(2/1/0) link status	pcie2_num	pcie1_num	pcie0_num
 		break;
 	}
 
-/*
-	ioport_resource.start = mt7621_res_pci_io1.start;
-	ioport_resource.end = mt7621_res_pci_io1.end;
-*/
+	/*
+	 * ioport_resource.start = mt7621_res_pci_io1.start;
+	 * ioport_resource.end = mt7621_res_pci_io1.end;
+	 */
 
 	RALINK_PCI_MEMBASE = 0xffffffff; //RALINK_PCI_MM_MAP_BASE;
 	RALINK_PCI_IOBASE = RALINK_PCI_IO_MAP_BASE;
@@ -641,26 +636,26 @@ pcie(2/1/0) link status	pcie2_num	pcie1_num	pcie0_num
 	switch (pcie_link_status) {
 	case 7:
 		read_config(0, 2, 0, 0x4, &val);
-		write_config(0, 2, 0, 0x4, val|0x4);
+		write_config(0, 2, 0, 0x4, val | 0x4);
 		read_config(0, 2, 0, 0x70c, &val);
-		val &= ~(0xff)<<8;
-		val |= 0x50<<8;
+		val &= ~(0xff) << 8;
+		val |= 0x50 << 8;
 		write_config(0, 2, 0, 0x70c, val);
 	case 3:
 	case 5:
 	case 6:
 		read_config(0, 1, 0, 0x4, &val);
-		write_config(0, 1, 0, 0x4, val|0x4);
+		write_config(0, 1, 0, 0x4, val | 0x4);
 		read_config(0, 1, 0, 0x70c, &val);
-		val &= ~(0xff)<<8;
-		val |= 0x50<<8;
+		val &= ~(0xff) << 8;
+		val |= 0x50 << 8;
 		write_config(0, 1, 0, 0x70c, val);
 	default:
 		read_config(0, 0, 0, 0x4, &val);
-		write_config(0, 0, 0, 0x4, val|0x4); //bus master enable
+		write_config(0, 0, 0, 0x4, val | 0x4); //bus master enable
 		read_config(0, 0, 0, 0x70c, &val);
-		val &= ~(0xff)<<8;
-		val |= 0x50<<8;
+		val &= ~(0xff) << 8;
+		val |= 0x50 << 8;
 		write_config(0, 0, 0, 0x70c, val);
 	}
 
@@ -668,7 +663,6 @@ pcie(2/1/0) link status	pcie2_num	pcie1_num	pcie0_num
 	setup_cm_memory_region(mt7621_controller.mem_resource);
 	register_pci_controller(&mt7621_controller);
 	return 0;
-
 }
 
 int pcibios_plat_dev_init(struct pci_dev *dev)
-- 
2.7.4

