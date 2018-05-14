Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752646AbeENITN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 04:19:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:53332 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752135AbeENITK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 04:19:10 -0400
Date: Mon, 14 May 2018 10:19:08 +0200
From: Jean Delvare <jdelvare@suse.de>
To: Borislav Petkov <bp@suse.de>
Cc: kbuild test robot <lkp@intel.com>, Tony Luck <tony.luck@intel.com>,
        kbuild-all@01.org, linux-kernel@vger.kernel.org
Subject: Re: drivers/edac/skx_edac.c:399: undefined reference to
 `nfit_get_smbios_id'
Message-ID: <20180514101908.0381e63d@endymion>
In-Reply-To: <20180514081200.GA18407@pd.tnic>
References: <201805130419.XbKBtNfM%fengguang.wu@intel.com>
        <20180514100530.3f2d0667@endymion>
        <20180514081200.GA18407@pd.tnic>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 May 2018 10:12:00 +0200, Borislav Petkov wrote:
> On Mon, May 14, 2018 at 10:05:30AM +0200, Jean Delvare wrote:
> > I'll send a candidate fix shortly.  
> 
> https://lkml.kernel.org/r/3af91354-8e19-d2af-1bba-ced8dce053f1@infradead.org

Thanks for the link, apparently I'm late to the party. Oh well.

-- 
Jean Delvare
SUSE L3 Support
