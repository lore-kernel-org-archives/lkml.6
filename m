Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751544AbeBZTtJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 14:49:09 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:44876 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751340AbeBZTtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 14:49:07 -0500
Message-ID: <1519674546.3941.2.camel@HansenPartnership.com>
Subject: Re: [GIT PULL] tpmdd fixes for 4.16
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: James Morris <jmorris@namei.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org
Date: Mon, 26 Feb 2018 11:49:06 -0800
In-Reply-To: <alpine.LRH.2.21.1802270552260.29062@namei.org>
References: <20180226124144.GA8675@linux.intel.com>
         <alpine.LRH.2.21.1802270552260.29062@namei.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-02-27 at 05:52 +1100, James Morris wrote:
> On Mon, 26 Feb 2018, Jarkko Sakkinen wrote:
> 
> > 
> > Hi
> > 
> > Here is a batch of critical fixes for 4.16.
> > 
> 
> Do you have CVEs for these?  If so, please include them in the commit
> messages.

Heh, well, I suppose from this everyone now knows they're fixes for
vulnerabilities.  The CVE doesn't usually show up until after the
embargo is released, so we don't have one yet.

James
