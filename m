Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752091AbeDIKZw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 06:25:52 -0400
Received: from smtprelay0170.hostedemail.com ([216.40.44.170]:49707 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751704AbeDIKZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 06:25:51 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::,RULES_HIT:41:355:379:541:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1567:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:2902:3138:3139:3140:3141:3142:3622:3865:3867:3868:3870:3871:3872:4321:4605:5007:6119:7903:10004:10400:10848:11232:11658:11914:12043:12048:12679:12740:12760:12895:13069:13095:13181:13229:13311:13357:13439:14659:14721:21080:21433:21627:30054:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: table65_4fcb664aa1f3d
X-Filterd-Recvd-Size: 1684
Message-ID: <0dad6b43476c1a70944e3e7c245040243ddc2a04.camel@perches.com>
Subject: Re: [PATCH v2 7/9] PCI: dwc: Replace lower into upper case
 characters
From: Joe Perches <joe@perches.com>
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, Joao.Pinto@synopsys.com,
        jingoohan1@gmail.com, kishon@ti.com, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Date: Mon, 09 Apr 2018 03:25:46 -0700
In-Reply-To: <a28d463d04b198f51c64c1a7eb5b3f77da2d4ab9.1523266508.git.gustavo.pimentel@synopsys.com>
References: <cover.1523266508.git.gustavo.pimentel@synopsys.com>
         <a28d463d04b198f51c64c1a7eb5b3f77da2d4ab9.1523266508.git.gustavo.pimentel@synopsys.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.0-4 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-04-09 at 10:41 +0100, Gustavo Pimentel wrote:
> Replaces lower into upper case characters in comments and debug printks.
> 
> This is an attempt to keep the messages coherent within the designware
> driver.

It'd be nice to make all the dwc drivers use the same
message wording.

For instance:

drivers/pci/dwc/pci-keystone.c: dev_err(dev, "phy link never came up\n");
drivers/pci/dwc/pcie-designware.c:      dev_err(pci->dev, "phy link never came up\n");
drivers/pci/host/pcie-xilinx-nwl.c:     dev_err(dev, "PHY link never came up\n");
