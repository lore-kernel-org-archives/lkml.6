Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932246AbeCIRLF (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 12:11:05 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:38820 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932070AbeCIRLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 12:11:03 -0500
Message-ID: <1520615461.12216.6.camel@HansenPartnership.com>
Subject: Re: [PATCH] security: Fix IMA Kconfig for dependencies on ARM64
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jiandi An <anjiandi@codeaurora.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        linux-integrity@vger.kernel.org, linux-ima-devel@lists.sourceforge.net,
        linux-ima-user@lists.sourceforge.net,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 09 Mar 2018 09:11:01 -0800
In-Reply-To: <191cfd49-0c66-a5ef-3d2b-b6c4132aa294@codeaurora.org>
References: <1520400386-17674-1-git-send-email-anjiandi@codeaurora.org>
         <20180307185132.GA30102@ziepe.ca>
         <1520448953.10396.565.camel@linux.vnet.ibm.com>
         <1520449719.5558.28.camel@HansenPartnership.com>
         <1520450495.10396.587.camel@linux.vnet.ibm.com>
         <1520451662.24314.5.camel@HansenPartnership.com>
         <1520461156.10396.654.camel@linux.vnet.ibm.com>
         <191cfd49-0c66-a5ef-3d2b-b6c4132aa294@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-03-08 at 12:42 -0600, Jiandi An wrote:
[...]
> I'm no expert on IMA and its driver.  James, will you be kind enough
> to look into overhauling the IMA driver to not measure until after 
> initrd phase if that's the consensus on resolving this?

I'll add it to my todo list.

Since my TPM 2.0 test environment is a VM with a tpm that has a network
connection to an emulator on my host, it's impossible to set it up so
that it's built in (because you need the network config before you init
the TPM) so I might accelerate if I suddenly need to debug IMA issues
in this configuration.

James
