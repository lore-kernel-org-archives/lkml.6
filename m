Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751316AbeCHUw4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 15:52:56 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36554 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751185AbeCHUwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 15:52:55 -0500
Date: Thu, 8 Mar 2018 21:52:14 +0100
From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To: Wanpeng Li <kernellwp@gmail.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 3/3] KVM: X86: Provides userspace with a capability to
 not intercept PAUSE
Message-ID: <20180308205213.GL12290@flask>
References: <1519897782-8124-1-git-send-email-wanpengli@tencent.com>
 <1519897782-8124-3-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1519897782-8124-3-git-send-email-wanpengli@tencent.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-01 17:49+0800, Wanpeng Li:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> Allow to disable pause loop exit/pause filtering on a per VM basis.
> 
> If some VMs have dedicated host CPUs, they won't be negatively affected
> due to needlessly intercepted PAUSE instructions.
> 
> Thanks to Jan H. Schönherr's initial patch.

Please Cc him on v2.
