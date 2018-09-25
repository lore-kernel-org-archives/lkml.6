Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041BEC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A411020880
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:17:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A411020880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbeIZC0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 22:26:37 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39063 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbeIZC0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 22:26:37 -0400
Received: by mail-ot1-f65.google.com with SMTP id c12-v6so25793057otl.6;
        Tue, 25 Sep 2018 13:17:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yiRX1+l8RmI0L9BX7rbYr204O7WUHgYLwu8wGtvuVwA=;
        b=EFZpcCPjppTa/kwBMMQ5t4ckq/0x1//6/FJn2PHQKgmWbk3PVELjGDEHShLL9ICHuP
         XLq4/ZbDSL7xmzCa86cSpgOmwnXdfGw94l6gNjsUD1cpNdLpOpIF5L7QbOBIiJvhjXDc
         8fLzoDirhiVo8/rlDD1ZGOuAuiXJHpn10AJfFwTxY3ZNe7285oHZzVTJVMmzY6ibe+79
         rtWLhcENrkJOJS+yL9tkZd1FDddlo6fEZpCtFwuPFCu6ybEEWGH4ewI3oLyGtEDy0r/G
         6T0D7nCiTdf7qv2x38CeJwlm9WyXoivh9D9IhSL02eTWF00/3ZvWVI8yXuLeEE7oMSuj
         v0Nw==
X-Gm-Message-State: ABuFfohucVgfqzLZJUgyn1RI/iuDsRffFtWbSk0iStuemdFFy8BtFqf/
        LPX3bhv4F/yKP4ro8fJkcA==
X-Google-Smtp-Source: ACcGV61xHTDI+HrbPN+8PS2AdCIaV8XLe8bkiruy/v2T188haqxXIbwE6Dpgzk47sZFCzefo/QtQeQ==
X-Received: by 2002:a9d:3c1d:: with SMTP id q29-v6mr1977070otc.158.1537906641443;
        Tue, 25 Sep 2018 13:17:21 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j29-v6sm348607otb.67.2018.09.25.13.17.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 13:17:20 -0700 (PDT)
Date:   Tue, 25 Sep 2018 15:17:20 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nava kishore Manne <nava.manne@xilinx.com>
Cc:     mark.rutland@arm.com, michal.simek@xilinx.com, atull@kernel.org,
        mdf@kernel.org, jollys@xilinx.com, sboyd@kernel.org,
        rajanv@xilinx.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org, chinnikishore369@gmail.com
Subject: Re: [RFC PATCH v2 2/3] dt-bindings: fpga: Add bindings for ZynqMP
 fpga driver
Message-ID: <20180925201720.GA32354@bogus>
References: <20180905072448.12488-1-nava.manne@xilinx.com>
 <20180905072448.12488-3-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180905072448.12488-3-nava.manne@xilinx.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 12:54:47PM +0530, Nava kishore Manne wrote:
> Add documentation to describe Xilinx ZynqMP fpga driver
> bindings.
> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> ---
> Changes for v2:
>                 -Moved pcap node as a child to firwmare
>                  node as suggested by Rob.

Sorry, but I wasn't thinking that you already have a node defined under 
/firmware. There's no reason to have this pcap node as a child of it. 
The existing node can instantiate multiple providers including this and 
reset provider.

>  .../firmware/xilinx/xlnx,zynqmp-firmware.txt        | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
