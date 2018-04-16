Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752326AbeDPQ06 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 12:26:58 -0400
Received: from mail-ot0-f178.google.com ([74.125.82.178]:45428 "EHLO
        mail-ot0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751002AbeDPQ04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 12:26:56 -0400
X-Google-Smtp-Source: AIpwx48ZRa73QMqddESMqmJ/K4HV6YoHr+IgEN5doOjYbErzeRFENnz5+XDFeHZjmgHLs72QtW2aYIU7U1L+ddAiRWw=
MIME-Version: 1.0
In-Reply-To: <1523797962.32594.75.camel@amazon.de>
References: <1523744804-8220-1-git-send-email-karahmed@amazon.de> <1523797962.32594.75.camel@amazon.de>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 16 Apr 2018 09:26:55 -0700
Message-ID: <CALMp9eSHOUS6N+VohNQ6Fibu-Yc9965f0KhWKXUQOg-97mtpcw@mail.gmail.com>
Subject: Re: [PATCH] KVM: Switch 'requests' to be 64-bit (explicitly)
To: "Raslan, KarimAllah" <karahmed@amazon.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3GGR1Ev013505

On Sun, Apr 15, 2018 at 6:12 AM, Raslan, KarimAllah <karahmed@amazon.de> wrote:
> On Sun, 2018-04-15 at 00:26 +0200, KarimAllah Ahmed wrote:
>> Switch 'requests' to be explicitly 64-bit and update BUILD_BUG_ON check to
>> use the size of "requests" instead of the hard-coded '32'.
>>
>> That gives us a bit more room again for arch-specific requests as we
>> already ran out of space for x86 due to the hard-coded check.
>>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Radim Krčmář <rkrcmar@redhat.com>
>> Cc: kvm@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>

I like it!

Reviewed-by: Jim Mattson <jmattson@google.com>
