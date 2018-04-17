Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752747AbeDQOVf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 10:21:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40912 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751270AbeDQOVd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 10:21:33 -0400
Date: Tue, 17 Apr 2018 22:21:25 +0800
From: Baoquan He <bhe@redhat.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Philipp Rudo <prudo@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>,
        Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
        Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v1 0/2] kexec: Remove "weak" annotations from headers
Message-ID: <20180417142125.GE1750@localhost.localdomain>
References: <152355706051.36693.9856090891621551967.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20180413110820.662d4879@ThinkPad>
 <20180413092908.GB2119@localhost.localdomain>
 <20180417140714.GF28657@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180417140714.GF28657@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/17/18 at 09:07am, Bjorn Helgaas wrote:
> On Fri, Apr 13, 2018 at 05:29:08PM +0800, Baoquan He wrote:
> > Hi Bjorn,
> > 
> > There are changes I have made to solve 5-level conflict with
> > kexec/kdump and also interface unification task, they will involve x86
> > 64 only changes on these functions, I don't think we need remove them if
> > without any obvious impact or error reported.
> 
> Removing the weak attribute from the declaration in the header file
> does not prevent you from defining a weak function later in the .c
> file.

OK, sounds good to me. Then I have no concern to this, thanks.
Will see if other people have comments.

Thanks
Baoquan
