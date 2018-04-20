Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1692876-1524230961-2-4125867447415940728
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
    1524230961; b=DF5ifc+83czXe+GPH94pch5oZev2uhIYbCls+TvmIn1bULAsci
    YGFmfCrqsnZjJTunUc9P4yxGjfDmGMp/thYMFVAljvJ1aSlN8SFCstVyuvcE+ygo
    Ghc/EKjjZctq8pggcCBLVkgJbFbsKYpM5cMULAq5UFTd5M8677lOZUbpAMlZZn2p
    KjV5HEesR4N3Bg/LQlh+1+gMKLv0nvpj8UnlJyZmFaL5req1ef0+Bc685cjeuPDK
    N0zZlpSFtYeyN0n2qtNDcawQJpokZC85AuZ7sCKwL+QnReMELMtXc0FuFelr7IB1
    +LO/G8LFYvVzXxEHm1CsJCx0wXqJ5EvJ8wYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524230961; bh=7Zogm
    1RItC6pP5nwtYUMUI3o8VP89ZXlIb/CA51Xgf0=; b=Z+ZNycXJocgV+vh+7Veez
    UmLhqo7JYKFXOHQQzbE5mx1rWLThUMPtk3z+Jwp20cwrgCUXxSYBXic1iCMy3Bbg
    5S2eVms9YMrGLKufzYDi75AGuMDxeGByCUwLcMjQ73yt7zOQzAh/ATyJ91tbOzM4
    7lShVbZYyFaZxulMBnRLH5zMz9Ryp7Wh494LWVN1fcIw01cHDyV1bPd+x/Yd17Ws
    RF4BMbSF6SIy657nGkUm699USi92kFUp43Bh0k+/Et8tTcB49lKgOcwvg4GBTTJo
    P/PtSyTlFE4eYokkfB0Eecq5XZQx51qeMVXDmiEKTIVd84cRoUslpCca4dYF5rNJ
    g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfJKtS5f+qGHX5VGACzQkwlJvspAdN3YUeMPw1DI8we9h2ilyNLE4tLq528AsvNzUXBpWrOt+TAXziGBvFPrL9jOtLouGyLHzE55Xr1HrWnsVDOZS6ZDG
    gxNOKHt1hFfpl2/5ph3ObQuVBgaJ/OqKhWV6SsTs91MJa0Zmt5fqSNypmSvZWFNRmrjcjd8Rl/W1IIA9Vs7ATK/qLJZiY0J317LkJYEFiYa5zvxtjX4Q540X
    tB+WKCwrtauNXj6KF6h+fA==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=MKtGQD3n3ToA:10
    a=1oJP67jkp3AA:10 a=Kd1tUaAdevIA:10 a=d53lkjku8EkA:10 a=-uNXE31MpBQA:10
    a=jJxKW8Ag-pUA:10 a=ZZnuYtJkoWoA:10 a=DDOyTI_5AAAA:8 a=X0ydXipC49gFXsXZzmYA:9
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
Subject: [PATCH 4/8] sh_eth: Change platform check to CONFIG_ARCH_RENESAS
Date: Fri, 20 Apr 2018 15:28:30 +0200
Message-Id: <1524230914-10175-5-git-send-email-geert+renesas@glider.be>
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

Since commit 9b5ba0df4ea4f940 ("ARM: shmobile: Introduce ARCH_RENESAS")
is CONFIG_ARCH_RENESAS a more appropriate platform check than the legacy
CONFIG_ARCH_SHMOBILE, hence use the former.

Renesas SuperH SH-Mobile SoCs are still covered by the CONFIG_CPU_SH4
check.

This will allow to drop ARCH_SHMOBILE on ARM and ARM64 in the near
future.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/net/ethernet/renesas/sh_eth.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/renesas/sh_eth.h b/drivers/net/ethernet/renesas/sh_eth.h
index a5b792ce2ae7d046..1bf930d4a1e52c18 100644
--- a/drivers/net/ethernet/renesas/sh_eth.h
+++ b/drivers/net/ethernet/renesas/sh_eth.h
@@ -163,7 +163,7 @@ enum {
 };
 
 /* Driver's parameters */
-#if defined(CONFIG_CPU_SH4) || defined(CONFIG_ARCH_SHMOBILE)
+#if defined(CONFIG_CPU_SH4) || defined(CONFIG_ARCH_RENESAS)
 #define SH_ETH_RX_ALIGN		32
 #else
 #define SH_ETH_RX_ALIGN		2
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
