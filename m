Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754171AbeDMJBP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 05:01:15 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:36302 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754156AbeDMJBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 05:01:13 -0400
X-Google-Smtp-Source: AIpwx49424w4iztKdGHao5Ww7aQ5QCT6imidtdfZBZ5zIyhwRQ/g5qtwhUyD1Dqu3wOlUmqPQkSUKps6YPuis+tIZdc=
MIME-Version: 1.0
In-Reply-To: <1523607658-9166-3-git-send-email-eric.auger@redhat.com>
References: <1523607658-9166-1-git-send-email-eric.auger@redhat.com> <1523607658-9166-3-git-send-email-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Apr 2018 10:00:52 +0100
Message-ID: <CAFEAcA9iickG6uqYE+046GgAXVCnZ7cBkSvE4UKHBmxXpxZW1g@mail.gmail.com>
Subject: Re: [PATCH v3 02/12] KVM: arm/arm64: Document KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION
To: Eric Auger <eric.auger@redhat.com>
Cc: Eric Auger <eric.auger.pro@gmail.com>,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kvm-devel <kvm@vger.kernel.org>, kvmarm@lists.cs.columbia.edu,
        Marc Zyngier <marc.zyngier@arm.com>,
        Christoffer Dall <cdall@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Andrew Jones <drjones@redhat.com>, Wei Huang <wei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 April 2018 at 09:20, Eric Auger <eric.auger@redhat.com> wrote:
> We introduce a new KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION attribute in
> KVM_DEV_ARM_VGIC_GRP_ADDR group. It allows userspace to provide the
> base address and size of a redistributor region
>
> Compared to KVM_VGIC_V3_ADDR_TYPE_REDIST, this new attribute allows
> to declare several separate redistributor regions.
>
> So the whole redist space does not need to be contiguous anymore.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
