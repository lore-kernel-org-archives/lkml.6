Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752311AbeCJMoM (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 07:44:12 -0500
Received: from mga12.intel.com ([192.55.52.136]:53559 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752081AbeCJMoK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 07:44:10 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,451,1515484800";
   d="scan'208";a="37605537"
Message-ID: <3922f20fc01b7c5f555b92db5a128ee3a2d5cc12.camel@linux.intel.com>
Subject: Re: [PATCH 1/3 RESEND] tpm: add longer timeouts for creation
 commands.
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Jonathan Corbet <corbet@lwn.net>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
        "Winkler, Tomas" <tomas.winkler@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date: Sat, 10 Mar 2018 14:44:01 +0200
In-Reply-To: <20180307085454.2c820a13@lwn.net>
References: <20180304121205.16934-1-tomas.winkler@intel.com>
         <20180305125642.GA3425@linux.intel.com>
         <5B8DA87D05A7694D9FA63FD143655C1B9422E21E@hasmsx108.ger.corp.intel.com>
         <20180306074932.GB3624@linux.intel.com>
         <5B8DA87D05A7694D9FA63FD143655C1B9422EFFE@hasmsx108.ger.corp.intel.com>
         <1520353933.5393.21.camel@HansenPartnership.com>
         <1520361396.10396.396.camel@linux.vnet.ibm.com>
         <20180307085454.2c820a13@lwn.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.27.90-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-03-07 at 08:54 -0700, Jonathan Corbet wrote:
> On Tue, 06 Mar 2018 13:36:36 -0500
> Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> 
> > I've heard that some maintainers are moving away from cover letters,
> > since they are not include in the git repo and are lost.
> 
> If I get a patch series with a cover letter that should be preserved, I
> apply the series in a branch then do a no-ff merge; the cover letter can
> then go into the merge commit.  There's no reason why cover letters need to
> be lost.

That is an awesome idea. I'll start using this approach. Thank you.

/Jarkko
