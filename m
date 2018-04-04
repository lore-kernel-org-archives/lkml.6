Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752648AbeDDRGW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 13:06:22 -0400
Received: from mail-yb0-f173.google.com ([209.85.213.173]:36605 "EHLO
        mail-yb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752238AbeDDRGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 13:06:20 -0400
X-Google-Smtp-Source: AIpwx49YENabvuKc/+mAr/M9pi99rYaiiDv0JVoutgJ58013jESQXxnS24hh0yFcjZWNlwZ94z3zoA==
Date: Wed, 4 Apr 2018 10:06:17 -0700
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: IDE-ML <linux-ide@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] libata changes for v4.17-rc1
Message-ID: <20180404170617.GB3126663@devbig577.frc2.facebook.com>
References: <20180403143257.GN388343@devbig577.frc2.facebook.com>
 <CA+55aFyU+MnzfTfkvCgNJp+QZJdyfYrJmdzy0Z_PbxOcBTfByA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFyU+MnzfTfkvCgNJp+QZJdyfYrJmdzy0Z_PbxOcBTfByA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 03, 2018 at 05:59:04PM -0700, Linus Torvalds wrote:
> People hotplug ATA _controllers_?   :-O
> 
> As opposed to just the disks a'la eSATA?

Heh, yeah, it's surprising.  IIUC, it's people trying pcie hotplug (I
don't know whether they try physically) on SAS controllers on fancy
machines.

Thanks.

-- 
tejun
