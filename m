Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41836C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 12:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D6B72086A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 12:10:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D6B72086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=keep-it-simple.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389575AbeKPWWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 17:22:53 -0500
Received: from martinlund.org ([173.255.130.145]:44176 "EHLO
        slmp-550-86.slc.westdc.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727727AbeKPWWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 17:22:53 -0500
Received: from mail-ot1-f50.google.com ([209.85.210.50]:35162)
        by slmp-550-86.slc.westdc.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <martin.lund@keep-it-simple.com>)
        id 1gNcxS-00Dl7T-9t
        for linux-kernel@vger.kernel.org; Fri, 16 Nov 2018 05:10:46 -0700
Received: by mail-ot1-f50.google.com with SMTP id 81so21133007otj.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 04:10:46 -0800 (PST)
X-Gm-Message-State: AGRZ1gKPhGulWMhbREzZ7r47v2pWKnsF7QAKqAcs7DmOGXq1hPbRzxBg
        rsM6MwhUHk5fmhzIS3femJX4cS/tRcPa5D+MZH0=
X-Google-Smtp-Source: AJdET5fXpLA3j7ok2iCy1P06v6/NGRSyWwoc2zssx1r0vZdCZ35zJ1OEnNLtjvWg+UaviCnP+VKSs20pKmwZmIg44d0=
X-Received: by 2002:a9d:4282:: with SMTP id r2mr6563908ote.112.1542370245754;
 Fri, 16 Nov 2018 04:10:45 -0800 (PST)
MIME-Version: 1.0
References: <1541739641-17789-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
 <1541739641-17789-2-git-send-email-naga.sureshkumar.relli@xilinx.com> <CAB7pii3kx75ajF=8TsU7mWrmrzoHLiy7uAb+PirGw04BH65bZg@mail.gmail.com>
In-Reply-To: <CAB7pii3kx75ajF=8TsU7mWrmrzoHLiy7uAb+PirGw04BH65bZg@mail.gmail.com>
From:   Martin Lund <martin.lund@keep-it-simple.com>
Date:   Fri, 16 Nov 2018 13:10:34 +0100
X-Gmail-Original-Message-ID: <CAB7pii3LdMhaUhR1O8d5-79JYNnoO2c5cjnSC3qkhRH=hg+opw@mail.gmail.com>
Message-ID: <CAB7pii3LdMhaUhR1O8d5-79JYNnoO2c5cjnSC3qkhRH=hg+opw@mail.gmail.com>
Subject: Re: [LINUX PATCH v12 1/3] dt-bindings: mtd: arasan: Add device tree
 binding documentation
To:     naga.sureshkumar.relli@xilinx.com
Cc:     Martin Lund <martin.lund@keep-it-simple.com>,
        boris.brezillon@bootlin.com, miquel.raynal@bootlin.com,
        richard@nod.at, David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        =?UTF-8?B?TWFyZWsgVmHFoXV0?= <marek.vasut@gmail.com>,
        michals@xilinx.com, naga sureshkumar <nagasuresh12@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - slmp-550-86.slc.westdc.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - keep-it-simple.com
X-Get-Message-Sender-Via: slmp-550-86.slc.westdc.net: authenticated_id: martin.lund+keep-it-simple.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: slmp-550-86.slc.westdc.net: martin.lund@keep-it-simple.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 12:50 PM Martin Lund
<martin.lund@keep-it-simple.com> wrote:
> Compared with the example you will notice that "clock-name" should be
> "clock-names". reg was missing a "0x0".

Also, "sys" should be "clk_sys" and "flash" should be "clk_flash".
