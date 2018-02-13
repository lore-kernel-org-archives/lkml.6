Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933118AbeBMBJU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 20:09:20 -0500
Received: from mail-ot0-f172.google.com ([74.125.82.172]:43293 "EHLO
        mail-ot0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932736AbeBMBJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 20:09:19 -0500
X-Google-Smtp-Source: AH8x226ec6bFfkIpPo2b7SztiPd8i6G2oaYoK3z8QnCQF5BAEwv3MLIGkdPsDqEZ39xasO8KwQry3jSHReyuNm3KDQ0=
MIME-Version: 1.0
In-Reply-To: <20180212141218.GO13981@localhost.localdomain>
References: <1518319786-1466-1-git-send-email-wanpengli@tencent.com>
 <1518319786-1466-2-git-send-email-wanpengli@tencent.com> <20180212141218.GO13981@localhost.localdomain>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Tue, 13 Feb 2018 09:09:18 +0800
Message-ID: <CANRm+CzmOKSpyTLfa7mUJmhW9-QH9mwCE8WePpAGm7fhLJtgRw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] KVM: Introduce dedicated vCPUs hint KVM_HINTS_DEDICATED
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Andrew Jones <drjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-02-12 22:12 GMT+08:00 Eduardo Habkost <ehabkost@redhat.com>:
> On Sun, Feb 11, 2018 at 11:29:44AM +0800, Wanpeng Li wrote:
> [...]
>> +KVM_HINTS_DEDICATED                ||     0 || guest checks this feature bit
>> +                                   ||       || to determine if they run on dedicated
>> +                                   ||       || vCPUs, allowing optimizations
>
> What "dedicated vCPUs" mean, exactly?  Can we document this more
> explicitly?

Follow this and Andrew's comments in v4.

Regards,
Wanpeng Li
