Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935798AbeBLOMW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 09:12:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57694 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933415AbeBLOMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 09:12:21 -0500
Date: Mon, 12 Feb 2018 12:12:18 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
To: Wanpeng Li <kernellwp@gmail.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH v3 1/3] KVM: Introduce dedicated vCPUs hint
 KVM_HINTS_DEDICATED
Message-ID: <20180212141218.GO13981@localhost.localdomain>
References: <1518319786-1466-1-git-send-email-wanpengli@tencent.com>
 <1518319786-1466-2-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518319786-1466-2-git-send-email-wanpengli@tencent.com>
X-Fnord: you can see the fnord
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 11, 2018 at 11:29:44AM +0800, Wanpeng Li wrote:
[...]
> +KVM_HINTS_DEDICATED                ||     0 || guest checks this feature bit
> +                                   ||       || to determine if they run on dedicated
> +                                   ||       || vCPUs, allowing optimizations

What "dedicated vCPUs" mean, exactly?  Can we document this more
explicitly?

-- 
Eduardo
