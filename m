Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1692876-1524230960-2-13399536989398330324
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='be', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524230959; b=c5bodXChClT0HBdjX1oOFdCT88lDrWlu+kvMMVVcE0iCPdd4gx
    jG/1xRIDIUJqhYh3NJcErqmFPqmLWZTMMg+M55XdMsOocoTg/47mhTEludTJnJX1
    whtp8xlBT0YJ6R0HBimb14jPOz6bxVQvbMUKYubUaY89pPGqsSoZfjGZOnQq5TJz
    4YSXL4wECgMjM0vefdGAPVhKgqOfKJgzGgD/ihdJBtLljhe+x3mN/AF1+zRfOwMA
    aJ00+w5NG1gtlkQyS52tMo1j1ELB0quQzFI+oQPrUDZfWYET1ILZ43af41mru3Uh
    5kz/FinOBQ/wP7I+QKPTGdkl2qaUpsKbdtKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524230959; bh=THj0y
    jyknj+FJ8SdIIQK+Y1st8cgCZyLStBBwrVT8wY=; b=nr2IDpeIkMQEtr5jk5MXz
    O5HbtguB65R+3i5FTIp5Cj+9hnCCiFqb4LcM34RCb7lRzXFbfitJLOKE/xVyXYZP
    mcx6E9ul0usmfjP35RptMliFIMQ2JSK5E+Tbu4P8owoUYJTRTTrQF4XwSCyehy6a
    Xx7thsRR400h4sMYwygC05/f4Zf3a2ThZna22bwSi+Wqj/+RxCA3AyRlsXLKhuGw
    5IgP4G1+gQC/x7Upn7ZX/Nu+VMiSjDxzQvnB6wfxOlxrEJwNaOt+oPrBPtBq1lny
    xgnfiJzBza3BaoYI4yIrUCU5JjOdWko2PwEYgp+DWgcvkGHBx/am0nyOdEClyFuP
    w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=glider.be;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=glider.be header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=glider.be;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=glider.be header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFQYMR3xU0Fw7x5cqgWtaKo4bCN37hHRabbP4bP5GozTwOSsFFXP+yTDm1DenAjRwjxv69EZldK8QO/yePPqZgDChgYjUjOZRHmW62GBRukdjkGh0pWO
    tQ0H0mwKkPlbKojbuX3bHe6ISXpynxMIQPBI/4pYytroP36I90ZPf+PHc6AVkfp0hOqO2P+zP85EP3w679no1uTIbLefnpFTp4+fMheMy0quOcEyQUnOhPSV
    ncooP0K87ifsyoY2nh20Tg==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=MKtGQD3n3ToA:10
    a=1oJP67jkp3AA:10 a=Kd1tUaAdevIA:10 a=d53lkjku8EkA:10 a=-uNXE31MpBQA:10
    a=jJxKW8Ag-pUA:10 a=ZZnuYtJkoWoA:10 a=DDOyTI_5AAAA:8 a=nd_kxP2KSka8r-moUGUA:9
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
Subject: [PATCH 6/8] ASoC: sh: Update menu title and platform dependency
Date: Fri, 20 Apr 2018 15:28:32 +0200
Message-Id: <1524230914-10175-7-git-send-email-geert+renesas@glider.be>
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

Change the menu title to refer to "Renesas SoCs" instead of "SuperH", as
both SuperH and ARM SoCs are supported.

Since commit 9b5ba0df4ea4f940 ("ARM: shmobile: Introduce ARCH_RENESAS")
is ARCH_RENESAS a more appropriate platform dependency for Renesas ARM
SoCs than the legacy ARCH_SHMOBILE, hence use the former.
Renesas SuperH SH-Mobile SoCs are still covered by the SUPERH
dependency.

This will allow to drop ARCH_SHMOBILE on ARM and ARM64 in the near
future.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 sound/soc/sh/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sh/Kconfig b/sound/soc/sh/Kconfig
index 1aa5cd77ca24a06f..c1b7fb91e3063f2b 100644
--- a/sound/soc/sh/Kconfig
+++ b/sound/soc/sh/Kconfig
@@ -1,5 +1,5 @@
-menu "SoC Audio support for SuperH"
-	depends on SUPERH || ARCH_SHMOBILE || COMPILE_TEST
+menu "SoC Audio support for Renesas SoCs"
+	depends on SUPERH || ARCH_RENESAS || COMPILE_TEST
 
 config SND_SOC_PCM_SH7760
 	tristate "SoC Audio support for Renesas SH7760"
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
