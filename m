Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752666AbeA3OGh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 09:06:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45482 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751651AbeA3OGg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 09:06:36 -0500
Date: Tue, 30 Jan 2018 15:06:22 +0100
From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To: "Longpeng(Mike)" <longpeng2@huawei.com>
Cc: pbonzini@redhat.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        arei.gonglei@huawei.com, weidong.huang@huawei.com
Subject: Re: [PATCH] kvm: x86: remove efer_reload entry in kvm_vcpu_stat
Message-ID: <20180130140621.GC22015@flask>
References: <1516959248-67928-1-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1516959248-67928-1-git-send-email-longpeng2@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-01-26 17:34+0800, Longpeng(Mike):
> The efer_reload is never used since
> commit 26bb0981b3ff ("KVM: VMX: Use shared msr infrastructure"),
> so remove it.
> 
> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
> ---

Queued, thanks.
