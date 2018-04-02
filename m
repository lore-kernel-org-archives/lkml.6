Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751928AbeDBFiK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 01:38:10 -0400
Received: from mail-lf0-f41.google.com ([209.85.215.41]:39995 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751314AbeDBFiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 01:38:09 -0400
X-Google-Smtp-Source: AIpwx481SrOzpWlHM0T1UlRiFyIGa+gZ8jPD6eWysFiI9f0bL1+Ce264RlJqCsAFPYc8cSZePQ9cFw==
Date: Mon, 2 Apr 2018 08:38:03 +0300
From: Johan Hedberg <johan.hedberg@intel.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: Re: linux-next: Signed-off-by missing for commits in the net-next
 tree
Message-ID: <20180402053803.GA17750@x1c.home>
References: <20180402123019.2e04f084@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180402123019.2e04f084@canb.auug.org.au>
Organization: Intel Finland Oy - BIC 0357606-4 - PL 281, 00181 Helsinki
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Apr 02, 2018, Stephen Rothwell wrote:
>   45a42bc9cc65 ("Bluetooth: hci_bcm: Remove DMI quirk for the MINIX Z83-4")
>   f9b95db0165a ("Bluetooth: btrsi: remove unused including <linux/version.h>")
>   96e58d368fa6 ("Bluetooth: Set HCI_QUIRK_SIMULTANEOUS_DISCOVERY for BTUSB_QCA_ROME")
>   9ea471320e13 ("Bluetooth: Mark expected switch fall-throughs")
> 
> are missing a Signed-off-by from their committer.

I think this is because I fixed up a missing author name in "Bluetooth:
hci_bcm: Remove DMI quirk for the MINIX Z83-4" and did a push --force,
whereas these patches were originally committed by Marcel. Should I be
adding my signed-off-by to all affected patches when doing such rebases?

Johan
