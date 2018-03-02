Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936015AbeCBT3L (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 14:29:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:57570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751608AbeCBT3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 14:29:09 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BE7921725
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=helgaas@kernel.org
Date: Fri, 2 Mar 2018 13:29:07 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Tejun Heo <tj@kernel.org>,
        linux-pci@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] ahci/pci-quirks: Add PCI-id for the Highpoint
 Rocketraid 644L card
Message-ID: <20180302192907.GB202062@bhelgaas-glaptop.roam.corp.google.com>
References: <20180302103633.10592-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180302103633.10592-1-hdegoede@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 02, 2018 at 11:36:31AM +0100, Hans de Goede wrote:
> Hi All,
> 
> Here are 2 patches adding support for Highpoint Rocketraid 644L cards,
> they can be merged independently from each-other into their resp. subsys,
> but since they belong together I'm sending them out as a series.

Seems like it'd be nice to keep these together, so Tejun, feel free to
take both patches with my

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

on the pci/quirks.c patch.  If you'd prefer me to take them, just let
me know.
