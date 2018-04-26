Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753764AbeDZHiS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 03:38:18 -0400
Received: from mga09.intel.com ([134.134.136.24]:14064 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751465AbeDZHiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 03:38:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,330,1520924400";
   d="scan'208";a="36561044"
Message-ID: <6f5ba028f120d092bd5c96557144750518faf9c1.camel@intel.com>
Subject: Re: linux-next: manual merge of the wireless-drivers-next tree with
 the wireless-drivers tree
From: Luciano Coelho <luciano.coelho@intel.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>,
        Kalle Valo <kvalo@codeaurora.org>,
        Wireless <linux-wireless@vger.kernel.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Haim Dreyfuss <haim.dreyfuss@intel.com>,
        Shaul Triebitz <shaul.triebitz@intel.com>
Date: Thu, 26 Apr 2018 10:38:11 +0300
In-Reply-To: <20180426110917.446204af@canb.auug.org.au>
References: <20180426110917.446204af@canb.auug.org.au>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-04-26 at 11:09 +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the wireless-drivers-next tree got a
> conflict in:
> 
>   drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
> 
> between commit:
> 
>   77e30e10ee28 ("iwlwifi: mvm: query regdb for wmm rule if needed")
> 
> from the wireless-drivers tree and commits:
> 
>   9c4f7d512740 ("iwlwifi: move all NVM parsing code to the common
> files")
>   4c625c564ba2 ("iwlwifi: get rid of fw/nvm.c")
> 
> from the wireless-drivers-next tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your
> tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any
> particularly
> complex conflicts.

Thanks for resolving this, Stephen!

I checked your resolution and it's spot on.

--
Cheers,
Luca.
