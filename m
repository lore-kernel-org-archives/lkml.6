Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D38C6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 22:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E6AD280B1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 22:26:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E6AD280B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936810AbeF2W0K (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 18:26:10 -0400
Received: from bmailout3.hostsharing.net ([176.9.242.62]:34639 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936603AbeF2W0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 18:26:09 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id CC5C3100DA1A2;
        Sat, 30 Jun 2018 00:26:06 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 726671F8BA; Sat, 30 Jun 2018 00:26:06 +0200 (CEST)
Date:   Sat, 30 Jun 2018 00:26:06 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] PCI: Document patch submission hints
Message-ID: <20180629222606.GA4317@wunner.de>
References: <153030390808.57832.2200774416664543563.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <153030405971.57832.12860154795039493576.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153030405971.57832.12860154795039493576.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 03:27:39PM -0500, Bjorn Helgaas wrote:
> +  - Wrap changelogs to fit in 80 columns when shown by "git show", which
> +    adds 4 spaces.  I use "textwidth=75" in vim.

I guess the ideal width is subjective, I usually wrap at 72 chars because
then you've got 4 blanks on either side when viewed with "git log", which
I find neater than maxing out the horizontal width.

In some cases I deliberately wrap at less than 72 chars or allow 73 chars
if it avoids vastly unequal widths in a paragraph.  Often when I later
doublecheck what you've committed, I find that you've rewrapped everything
to 75 chars and the result doesn't look as neat as I wanted it to be.
Not a big deal, but thought I'd mention it now that you're codifying this
"rule" somewhat more formally.

Lukas
