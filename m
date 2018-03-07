Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934267AbeCGP4e (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 10:56:34 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37322 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933533AbeCGP43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 10:56:29 -0500
Date: Wed, 7 Mar 2018 16:55:49 +0100
From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, dmatlack@google.com
Subject: Re: [PATCH 0/2] KVM: nVMX: expose VMX capabilities as MSR features
Message-ID: <20180307155549.GD12290@flask>
References: <1519648809-16694-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519648809-16694-1-git-send-email-pbonzini@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-02-26 13:40+0100, Paolo Bonzini:
> These patches add the VMX capability MSRs to the /dev/kvm ioctls
> KVM_GET_MSR_FEATURE_INDEX_LIST and KVM_GET_MSRS, so that userspace
> can easily probe which VMX features are actually supported by KVM.
> 
> This will help the implementation of nested hypervisor migration,
> even for heterogeneous clusters.
> 
> Patch 1 is just refactoring, while patch 2 implements the feature.

Queued, thanks.
