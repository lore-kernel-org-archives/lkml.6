Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F3FC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 23:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FEB9216FD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 23:07:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FEB9216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753459AbeGCXHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 19:07:50 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:40137 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753325AbeGCXHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 19:07:48 -0400
Received: by mail-yw0-f194.google.com with SMTP id p129-v6so1284425ywg.7;
        Tue, 03 Jul 2018 16:07:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wsOtf/03woogAQyPrY9i0KVPyHgI6DnHVPFYmmu/zz0=;
        b=Q9rfyqHrMvBlAuSKhxESTUA8cDLmEP4fySKOCs7EYIKv2tk/dAVezXI+ZiAikkvYZV
         A9jd8EDX8t08J6T5/n3VgFy3UW2XU7lCTUzu/DJRlFbeXju+Y97icfuAs9++26XvdCdH
         69hUdp1cLhH+OGzKZfQwdZr+w1P6Oe4b+o+J9lSxzgpqx/QKIXoUnHftYnmUzaEvr/QK
         PAz8hlkdB99xLbNX7+g/ORH7VI0qYcRy2p9k9xOXDxNqZfWdulENYuBTwdGbWzBXooHR
         08yv+INryPjbOh81QHQhpHoDTAlrTduW8EYbbcmzRwml9T1fOaaRX/aUPjaHqhRBsv7g
         QExg==
X-Gm-Message-State: APt69E2TRAc52J+6W4psi5ghOW4SEaHsCzk6rP9OsmGgg95V7p7+Clyb
        YS/i7jx8XNKpb4NFx/Y4iA==
X-Google-Smtp-Source: AAOMgpe9Xf6IR0oSiGvi8jVIyvBeaJzWrUeqkeuiTLXZ4hQY4ofXEvUpJBklyPXnq6aIl8iIpmfUVQ==
X-Received: by 2002:a81:d806:: with SMTP id d6-v6mr15647385ywj.484.1530659267925;
        Tue, 03 Jul 2018 16:07:47 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id h126-v6sm832701ywf.73.2018.07.03.16.07.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 16:07:47 -0700 (PDT)
Date:   Tue, 3 Jul 2018 17:07:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Luis Araneda <luaraneda@gmail.com>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 5/5] arm: dts: zynq: remove "zynq" prefix from
 compatible property
Message-ID: <20180703230745.GA2129@rob-hp-laptop>
References: <20180628054205.17737-1-luaraneda@gmail.com>
 <20180628054205.17737-6-luaraneda@gmail.com>
 <042f6632-f4f6-d278-9859-b8998468c3bf@xilinx.com>
 <CAHbBuxpuAC0PDfFBQ+D_zJu-AmWFNhEWCojr8LAWfO-ootLqEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbBuxpuAC0PDfFBQ+D_zJu-AmWFNhEWCojr8LAWfO-ootLqEg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 03:18:49AM -0400, Luis Araneda wrote:
> Hi Michal,
> 
> On Thu, Jun 28, 2018 at 2:42 AM Michal Simek <michal.simek@xilinx.com> wrote:
> > zynq name here is correct which is saying that hardblock is going to be
> > described. Without it it is suggesting that hardblock is not used and it
> > is for example on zybo with microblaze.
> 
> In my opinion, the zynq name is just adding redundant information to
> the "xlnx,zynq-7000" value.

Maybe so, but you can't just go around changing compatible strings. Once 
set, it's an ABI.

Rob
