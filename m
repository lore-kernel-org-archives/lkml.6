Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934470AbeBMP6T (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 10:58:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:37018 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933730AbeBMP6S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 10:58:18 -0500
Date: Tue, 13 Feb 2018 16:58:16 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: David Rientjes <rientjes@google.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [patch] kvm: suppress KVM_SET_GSI_ROUTING allocation failure
Message-ID: <20180213155816.GW3443@dhcp22.suse.cz>
References: <alpine.DEB.2.10.1802081334120.133173@chino.kir.corp.google.com>
 <20180213144836.GU3443@dhcp22.suse.cz>
 <a68ddd16-dc7a-4ea7-ac33-ceff6d9276b8@redhat.com>
 <20180213154428.GV3443@dhcp22.suse.cz>
 <1083260b-dfcd-6354-4e0c-b7b162661b15@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1083260b-dfcd-6354-4e0c-b7b162661b15@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 13-02-18 16:49:20, Paolo Bonzini wrote:
> On 13/02/2018 16:44, Michal Hocko wrote:
> > On Tue 13-02-18 16:03:09, Paolo Bonzini wrote:
[...]
> >> There have been quite a few reports of this from syzkaller and generally
> >> we've fixed them.  It does seem like a recipe for NULL-pointer
> >> dereferences when the size is user-controlled (as in this case).
> > 
> > We do return NULL for that case regardless the above. The patch just
> > doesn't warn. Or do you think it is helpful to warn?
> 
> It certainly helps bringing potential issues in the spotlight (through
> fuzzing, mostly).

Fair enough.

-- 
Michal Hocko
SUSE Labs
