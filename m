Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932509AbeEHO1G (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 10:27:06 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35014 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932376AbeEHO1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 10:27:05 -0400
Date: Tue, 8 May 2018 11:27:00 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with global pages changeset and kvm
Message-ID: <20180508142659.GB3402@calabresa>
References: <20180508093723.GA4529@calabresa>
 <137272d9-9c30-3b28-0903-07add5e2036b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <137272d9-9c30-3b28-0903-07add5e2036b@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 08, 2018 at 07:15:06AM -0700, Dave Hansen wrote:
> Thanks for the excellent bug report!
> 
> On 05/08/2018 02:37 AM, Thadeu Lima de Souza Cascardo wrote:
> > 2) The bad address is next to do_syscall_64 on the host.
> 
> So a host address leaked into a guest oops?
> 
> We should bring the KVM folks into this and probably also need to widen
> the cc list quite a bit.
> 
> Can you boot the guest at all?

No, there are multiple oopses, the last one includes init, which makes the
guest panic. I can boot it if I add nopti to the guest command line.

Cascardo.
