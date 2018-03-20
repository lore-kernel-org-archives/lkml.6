Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751456AbeCTHS5 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 03:18:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:54742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750828AbeCTHSz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 03:18:55 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F5AE2177A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Mike Looijmans <mike.looijmans@topic.nl>,
        Rob Herring <robh@kernel.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <f25eb71c-efd9-f842-1a98-76c86b03a34a@topic.nl>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        mark.rutland@arm.com
References: <1521114608-21967-1-git-send-email-mike.looijmans@topic.nl>
 <20180318125219.ar7f2n4o73ljz6vg@rob-hp-laptop>
 <ec813ab3-88db-f6e3-eca1-b6ea58936fcf@topic.nl>
 <152149373621.242365.4815290210815209160@swboyd.mtv.corp.google.com>
 <f25eb71c-efd9-f842-1a98-76c86b03a34a@topic.nl>
Message-ID: <152153033462.254778.17337398489852735308@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2] clk: Add driver for the si544 clock generator chip
Date: Tue, 20 Mar 2018 00:18:54 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mike Looijmans (2018-03-20 00:15:36)
> Thanks, found them on patchwork, somehow they didn't end up in my mailbox.
> 
> Comments are clear, will incorporate them, I only have trouble with your 
> remark on the DT documentation "Can this reference stuff go to the bottom of 
> this document?". I copied the style from the other documents in the same 
> directory, I'm slightly puzzled about where the reference part should go now.
> 
> 

Ok. It's fine either way.
