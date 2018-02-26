Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751567AbeBZXen (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 18:34:43 -0500
Received: from namei.org ([65.99.196.166]:50712 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751079AbeBZXem (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 18:34:42 -0500
Date: Tue, 27 Feb 2018 10:33:37 +1100 (AEDT)
From: James Morris <jmorris@namei.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: Re: [GIT PULL] tpmdd fixes for 4.16
In-Reply-To: <1519674546.3941.2.camel@HansenPartnership.com>
Message-ID: <alpine.LRH.2.21.1802271033190.9747@namei.org>
References: <20180226124144.GA8675@linux.intel.com>         <alpine.LRH.2.21.1802270552260.29062@namei.org> <1519674546.3941.2.camel@HansenPartnership.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1665246916-613390738-1519688018=:9747"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1665246916-613390738-1519688018=:9747
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 26 Feb 2018, James Bottomley wrote:

> On Tue, 2018-02-27 at 05:52 +1100, James Morris wrote:
> > On Mon, 26 Feb 2018, Jarkko Sakkinen wrote:
> > 
> > > 
> > > Hi
> > > 
> > > Here is a batch of critical fixes for 4.16.
> > > 
> > 
> > Do you have CVEs for these?  If so, please include them in the commit
> > messages.
> 
> Heh, well, I suppose from this everyone now knows they're fixes for
> vulnerabilities.  The CVE doesn't usually show up until after the
> embargo is released, so we don't have one yet.

Anyone with half a brain can read Linus' -rc commits and work it out.

-- 
James Morris
<jmorris@namei.org>

--1665246916-613390738-1519688018=:9747--
