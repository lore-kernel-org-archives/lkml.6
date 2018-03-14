Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753491AbeCNHc3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 03:32:29 -0400
Received: from mga09.intel.com ([134.134.136.24]:39621 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751470AbeCNHc2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 03:32:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,469,1515484800";
   d="scan'208";a="38707439"
Message-ID: <1521012744.2087.13.camel@intel.com>
Subject: Re: int3403_driver_init needs over 330 ms to finish
From: Zhang Rui <rui.zhang@intel.com>
To: Paul Menzel <pmenzel+linux-pm@molgen.mpg.de>,
        Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 14 Mar 2018 15:32:24 +0800
In-Reply-To: <b6cf267e-3042-1226-cb06-1b7fc26ed122@molgen.mpg.de>
References: <b6cf267e-3042-1226-cb06-1b7fc26ed122@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 二, 2018-03-13 at 20:39 +0100, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> Booting the Dell XPS 13 9370 with Linux 4.16-rc4+ and
> `initcall_debug`, 
> shows it is shown that int3403_driver_init needs over 330 ms to run.
> 
>      [    2.524839] initcall int3403_driver_init+0x0/0x1000 
> [int3403_thermal] returned 0 after 333972 usecs
> 
I guess most of the time are spent in evaluating ACPI ASL code.
But anyway, please create a bugzilla report and attach both dmesg and
acpidump there.

thanks,
rui
> Please find all Linux messages attached.
> 
> Is there a way to reduce that time?
> 
> 
> Kind regards,
> 
> Paul
