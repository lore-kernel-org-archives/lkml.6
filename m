Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1807417-1527159237-2-9413510105005992089
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527159236; b=NXfZgsfPT0sP05wi3oVHotbRtOQc6fKJOfGjYU0dIcM9p0X1OV
    R+rBwNm0kA8mcLhNmr75FalTTjrb7iQlUMK59nrw/XqE6vFXr3zMQnLd0eIFvDZd
    yR9A90Zte02fJzXi88L7BstwXcnVzAqKzWLClF9vncef3Jipf3LX5Qj40R4fBihx
    HfTz1NB7dlSHkzSjqRKkPB1y011VPzclLWcdn4WR9LkIpOekp0n7Fw0p/2a1AsNh
    MJEclubwamWZuEpf+Vw8EfmhnEFk0cu7EPVEwul9utZ2u0pMwCrcee6Xt1vKvrgG
    7iAqWVc1Dgmeyw6nHN/WtRWyJ2XeDb6brtXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527159236; bh=1+0+lcgk7m4NwPEZxmU1aqXFsayxGY
    NoFU1mVk0QsJY=; b=DU+pNlTkdAfgmKKSS7uvkSzDAEKRlAmUg+ryxM0m3O832C
    N40GcZbVOwE1uURYFJmWfp9DspWvo0HI99XZrPcXFS1kQyc1NukBk8iTJy5F+8Ld
    3/PO1oQ2DGvm/re8qVEujLYn0BaswSzoC4jIKrl3k7PIFV3J9DwXSgvFAjgKSmba
    iQU8ss0aPZOx5/0UcFM4It1MPfXAE9GJSkolDIny1iQsJ+yNqL2ZyHC3PD+M1XSL
    07EMxMww7j31cmcRRVpN2e3N24f1hB94gGYfl+fQhh2FrNxIFdtMMoRbAC7L3eTP
    GnkeW13tC6WGliq4ytQ+yV0rMcc/tORyv/q1F0cQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=EG9R4Xt/ x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=EG9R4Xt/ x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIvzTW0+LQYfN2G/8Z2D6amCc3wyjmidArZjkXh98neIuW5SWiNHMQVBrmW7/71w82Z/MPUB9lae0+giskwZMRvKWE/Huk5uWVULXYmoWPp4Lj+gVtfZ
    AlsWJDQN2FgT/NwiFIW3X58FiSrq8KUA8ccErqf4+RRwgcELhFAPKi8ZzTZxFjwO2oBhGcNQ47ra+fMI/OOdaMD1soH6j4rsaP1nVbXQQiUt2R46bF0ZLr9b
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=j-NXPswCAAAA:8 a=m8ToADvmAAAA:8 a=Ikd4Dj_1AAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=RNOMWXZoqlZzpp3PYiAA:9 a=RdPg5fLVvLDu0hiv:21
    a=yYO6URiAGnNbBWEK:21 a=QEXdDO2ut3YA:10 a=UdV-L189IiqUQIgB40x4:22
    a=kCrBFHLFDAq2jDEeoMj9:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030384AbeEXJ5D (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:57:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:36832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030366AbeEXJ5A (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:57:00 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 129/165] clk: tegra: Fix pll_u rate configuration
Date: Thu, 24 May 2018 11:38:55 +0200
Message-Id: <20180524093627.222721421@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
References: <20180524093621.979359379@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marcel Ziswiler <marcel@ziswiler.com>

[ Upstream commit c35b518f9ba06c9de79fb3ff62eed7462d804995 ]

Turns out latest upstream U-Boot does not configure/enable pll_u which
leaves it at some default rate of 500 kHz:

root@apalis-t30:~# cat /sys/kernel/debug/clk/clk_summary | grep pll_u
       pll_u                  3        3        0      500000          0

Of course this won't quite work leading to the following messages:

[    6.559593] usb 2-1: new full-speed USB device number 2 using tegra-
ehci
[   11.759173] usb 2-1: device descriptor read/64, error -110
[   27.119453] usb 2-1: device descriptor read/64, error -110
[   27.389217] usb 2-1: new full-speed USB device number 3 using tegra-
ehci
[   32.559454] usb 2-1: device descriptor read/64, error -110
[   47.929777] usb 2-1: device descriptor read/64, error -110
[   48.049658] usb usb2-port1: attempt power cycle
[   48.759475] usb 2-1: new full-speed USB device number 4 using tegra-
ehci
[   59.349457] usb 2-1: device not accepting address 4, error -110
[   59.509449] usb 2-1: new full-speed USB device number 5 using tegra-
ehci
[   70.069457] usb 2-1: device not accepting address 5, error -110
[   70.079721] usb usb2-port1: unable to enumerate USB device

Fix this by actually allowing the rate also being set from within
the Linux kernel.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/tegra/clk-pll.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/clk/tegra/clk-pll.c
+++ b/drivers/clk/tegra/clk-pll.c
@@ -1151,6 +1151,8 @@ static const struct clk_ops tegra_clk_pl
 	.enable = clk_pllu_enable,
 	.disable = clk_pll_disable,
 	.recalc_rate = clk_pll_recalc_rate,
+	.round_rate = clk_pll_round_rate,
+	.set_rate = clk_pll_set_rate,
 };
 
 static int _pll_fixed_mdiv(struct tegra_clk_pll_params *pll_params,
