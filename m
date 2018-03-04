Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932188AbeCDUgq (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 15:36:46 -0500
Received: from mail-yw0-f176.google.com ([209.85.161.176]:43166 "EHLO
        mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751848AbeCDUgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 15:36:43 -0500
X-Google-Smtp-Source: AG47ELuRufoZHPDAKa4B+5lfDx5l6YUfkaW4Y17DlBCuCXLgLRRHcvOMv2OPuzzYPQ3sknBBcVcHRg==
Date: Sun, 4 Mar 2018 12:36:40 -0800
From: Tejun Heo <tj@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] ahci/pci-quirks: Add PCI-id for the Highpoint
 Rocketraid 644L card
Message-ID: <20180304203640.GF231488@devbig577.frc2.facebook.com>
References: <20180302103633.10592-1-hdegoede@redhat.com>
 <20180302192907.GB202062@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180302192907.GB202062@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 02, 2018 at 01:29:07PM -0600, Bjorn Helgaas wrote:
> On Fri, Mar 02, 2018 at 11:36:31AM +0100, Hans de Goede wrote:
> > Hi All,
> > 
> > Here are 2 patches adding support for Highpoint Rocketraid 644L cards,
> > they can be merged independently from each-other into their resp. subsys,
> > but since they belong together I'm sending them out as a series.
> 
> Seems like it'd be nice to keep these together, so Tejun, feel free to
> take both patches with my
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> on the pci/quirks.c patch.  If you'd prefer me to take them, just let
> me know.

Applied both to libata/for-4.16-fixes with ack added.

Thanks.

-- 
tejun
