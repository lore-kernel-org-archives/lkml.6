Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1692876-1524230948-2-1036587981977943873
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='be', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524230947; b=UYL2XdmowLQYDF9Emp7pCSe1s0xxKkncRelTX38f7sU/NmuSBf
    yqJSlv47ZgrdVLvWk0TNx+jBPkqEkiE7b6NZZUIh1kIeXIFuOomIVmAzj+iubNLa
    LnxzJ82rnDKP1Xq76G6woRFVEMM36Uk9u5LInx3TQ42ufhst0y3Qec1eRRbbcpnL
    Tn1b9jpcsmrXbstlkn1D55GnJlSbutkGm+LsI25r1IZAYgk86uhLvoR4Bcd6vO2q
    l5d/w2+2aZcfqx7lpvL4HR4xR7U0yI4d2jWlHjsWPvmDl8NCge0v0WNCJU39Sese
    Hw7Ogzjl9U/ymhBX+8qCDXtWDTUSxvVL1mOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524230947; bh=Vg/F9
    LA667DCOu16GIZitl4zf+/6QFBHTc3kH5pDh24=; b=rRK2O6FMFxBwlGNhj5lUw
    b84IZquS1cuBsBgm2I82BdOq+6Jw+4QI0GRBW1q/Y1S+0eSbtZCnAfF7l6I0NYAr
    1NVtE6qwo1hxQmR+MqlxKFtrn44Q8ywVAw7NPW3Ru7QZ+nUADkQn+n8/12EZjxg0
    grrc1qjzw49DL5sL7/zJwY73picbGRjrm9oZAmONue9Eur201PyaYI8aH9Whoxsv
    RWzoX/7tYcfjQ+d5r2j4cBz7kZWOUitrgzJmuCOLAQnTygLAdaRDG4BEnCLqbfQD
    YI+kWSJ38caa2ezLY4osi7JYCXpQQyCTn+Rf93oHd5IP0Xs1ikwJZlYyZcoe2fgJ
    A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=glider.be;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=glider.be header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=glider.be;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=glider.be header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfD6gt2zCpmJI0F6YlxiQAVc1XCemDyTfP/P+IC3ZuGLi/IJstr9pQ13zj85pEFCcSuR15jlfTGHHZsxigo3JUgtOQ4LPN8fOPpRbUpdfmBDNCKIfTtgr
    ckKDHUgsVZBA7GWJJzMK60HDRzOIcQYbZ/lsjozmxdsrkRiwoi1UyteUWx/FldKOE6l75Q8HfFDMt2bATl0ms4jSyffahf7RlxJfPfyJEvcIOMFWkvAt7N8B
    MgkLMIW6MmD4XnrXUVUs5A==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=MKtGQD3n3ToA:10
    a=1oJP67jkp3AA:10 a=Kd1tUaAdevIA:10 a=d53lkjku8EkA:10 a=-uNXE31MpBQA:10
    a=jJxKW8Ag-pUA:10 a=ZZnuYtJkoWoA:10 a=DDOyTI_5AAAA:8 a=DAWz7Q1sJEhHyRw7si8A:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Dan Williams <dan.j.williams@intel.com>,
 Vinod Koul <vinod.koul@intel.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
 "David S . Miller" <davem@davemloft.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH/RFC 7/8] ARM: shmobile: Remove the ARCH_SHMOBILE Kconfig symbol
Date: Fri, 20 Apr 2018 15:28:33 +0200
Message-Id: <1524230914-10175-8-git-send-email-geert+renesas@glider.be>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524230914-10175-1-git-send-email-geert+renesas@glider.be>
References: <1524230914-10175-1-git-send-email-geert+renesas@glider.be>
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
Cc: devel@driverdev.osuosl.org, alsa-devel@alsa-project.org,
 Geert Uytterhoeven <geert+renesas@glider.be>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

All drivers for Renesas ARM SoCs have gained proper ARCH_RENESAS
platform dependencies.  Hence finish the conversion from ARCH_SHMOBILE
to ARCH_RENESAS for Renesas 32-bit ARM SoCs, as started by commit
9b5ba0df4ea4f940 ("ARM: shmobile: Introduce ARCH_RENESAS").

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This depends on the previous patches in this series, hence the RFC.

JFTR, after this, the following symbols for drivers supporting only
Renesas SuperH "SH-Mobile" SoCs can no longer be selected:
  - CONFIG_KEYBOARD_SH_KEYSC,
  - CONFIG_VIDEO_SH_VOU,
  - CONFIG_VIDEO_SH_MOBILE_CEU,
  - CONFIG_DRM_SHMOBILE[*],
  - CONFIG_FB_SH_MOBILE_MERAM.
(changes for a shmobile_defconfig .config)

[*] CONFIG_DRM_SHMOBILE has a dependency on ARM, but it was never wired
    up.  From the use of sh_mobile_meram, I guess it was meant for
    SH-Mobile AP4 on Mackerel or AP4EVB, which are long gone.
    So the only remaining upstream platforms that could make use of it
    are legacy SuperH SH-Mobile SoCs?
---
 arch/arm/mach-shmobile/Kconfig | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 96672da02f5f17b9..d892c5b52b6f5627 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -1,6 +1,3 @@
-config ARCH_SHMOBILE
-	bool
-
 config PM_RMOBILE
 	bool
 	select PM
@@ -30,7 +27,6 @@ menuconfig ARCH_RENESAS
 	bool "Renesas ARM SoCs"
 	depends on ARCH_MULTI_V7 && MMU
 	select ARCH_DMA_ADDR_T_64BIT if ARM_LPAE
-	select ARCH_SHMOBILE
 	select ARM_GIC
 	select GPIOLIB
 	select HAVE_ARM_SCU if SMP
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
