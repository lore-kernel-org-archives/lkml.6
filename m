Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752117AbeA3KAP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 05:00:15 -0500
Received: from mga05.intel.com ([192.55.52.43]:7213 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751391AbeA3KAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 05:00:11 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,434,1511856000";
   d="scan'208";a="199748904"
Date: Tue, 30 Jan 2018 15:34:45 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: "Yang, Shunyong" <shunyong.yang@hxt-semitech.com>
Cc: "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH 1/2] dmaengine: dmatest: change symbolic permissions
 to octal values
Message-ID: <20180130100444.GU18649@localhost>
References: <1516617881-30044-1-git-send-email-shunyong.yang@hxt-semitech.com>
 <20180129044801.GL18649@localhost>
 <1517207190.2845.6.camel@hxt-semitech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1517207190.2845.6.camel@hxt-semitech.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 29, 2018 at 06:26:40AM +0000, Yang, Shunyong wrote:
> Hi, Vinod
> 
> On Mon, 2018-01-29 at 10:18 +0530, Vinod Koul wrote:
> > On Mon, Jan 22, 2018 at 06:44:40PM +0800, Yang Shunyong wrote:
> > > 
> > > Current coding style prefers octal permissions values. This patch
> > > changes symbolic permissions to octal values.
> > Is this preference documented anywhere?
> > 
> 
> When using symbolic permissions like "S_IRUGO | S_IWUSR". The
> checkpatch.pl will output some warnings to suggest to use octal values.
> I quote following lines from checkpatch.pl,
> 
> # check for uses of S_<PERMS> that could be octal for readability
> ...
> if (WARN("SYMBOLIC_PERMS",
>                                  "Symbolic permissions '$oval' are not
> preferred. Consider using octal permissions '$octal'.\n" . $herecurr)
> &&

It is a warning and a preference. And I don't prefer changing code for no
benefit. Sorry but I am not considering this change

-- 
~Vinod
