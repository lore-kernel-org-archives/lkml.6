Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933278AbeCGOWS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 09:22:18 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:34763 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751176AbeCGOWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 09:22:17 -0500
X-Google-Smtp-Source: AG47ELtVTaARZhj7BVWlKsoIfqwFJFT8fqGYffHx2Kuxqw7/3CMRiux24Kzd4ykE27gS6lJCG7TKuay+kXZdB5cipEA=
MIME-Version: 1.0
In-Reply-To: <e30ac9b4-253c-106d-4ea5-604ec3eeb953@st.com>
References: <e30ac9b4-253c-106d-4ea5-604ec3eeb953@st.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 7 Mar 2018 15:22:15 +0100
X-Google-Sender-Auth: cRTlMuSsLvWDIHk3FyX691vk6OE
Message-ID: <CAK8P3a0eyD-LaW4CVZuOKzuOSoksW4saNoCyJm=dJjr9i7_-MA@mail.gmail.com>
Subject: Re: [GIT PULL] STi DT update for v4.17 round 1
To: Patrice CHOTARD <patrice.chotard@st.com>
Cc: "olof@lixom.net" <olof@lixom.net>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        "arm@kernel.org" <arm@kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 9:32 AM, Patrice CHOTARD <patrice.chotard@st.com> wrote:
> warn: You locally have sti-dt-for-v4.17-round1 but it does not (yet)
> warn: appear to be at
> git://git.kernel.org/pub/scm/linux/kernel/git/pchotard/sti.git
> warn: Do you want to push it there, perhaps?
> warning: refname 'sti-dt-for-v4.17-round1' is ambiguous.
> STi dts update:
>
> Fix all DT dtc warnings when building with W=1
> For most of implicated node, the addition of a fake reg property
> fixes these warnings.
> For others nodes, their location in device tree
> have been updated.
>

Something went wrong with your git-request-pull command, but
I have pulled the tag tags/sti-dt-for-v4.17-round1 into branch next/dt
now, as this seems to be what you had intended to send.

      Arnd
