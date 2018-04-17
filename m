Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752948AbeDQOKE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 10:10:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:33890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751211AbeDQOKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 10:10:02 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56B8E21727
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=helgaas@kernel.org
Date: Tue, 17 Apr 2018 09:09:59 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Philipp Rudo <prudo@linux.ibm.com>
Cc: Eric Biederman <ebiederm@xmission.com>,
        Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>, Dave Young <dyoung@redhat.com>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/2] kexec: Remove "weak" annotations from headers
Message-ID: <20180417140959.GG28657@bhelgaas-glaptop.roam.corp.google.com>
References: <152355706051.36693.9856090891621551967.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20180413110820.662d4879@ThinkPad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180413110820.662d4879@ThinkPad>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 13, 2018 at 11:08:20AM +0200, Philipp Rudo wrote:
> Hi Bjorn,
> 
> in recent patches AKASHI [1] and I [2] made some changes to the declarations
> you are touching and already removed some of the weak statements. The patches
> got accepted on linux-next and will (hopefully) be pulled for v4.17. So you
> should prepare for some merge conflicts. Nevertheless three weak statements
> still remain (arch_kexec_walk_mem & arch_kexec_apply_relocations*) so your
> patch still makes totally sense.

Thanks, I see those changes in v4.17-rc1.  I'll update my patches and
post a v2.
