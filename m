Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752706AbeCOO7e (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 10:59:34 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:47075 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752232AbeCOO7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 10:59:32 -0400
X-Google-Smtp-Source: AG47ELuqLkAmJu5woTFTj7z48X3T8QwC+166ZjwH20legaPot4fGn/iLcf93f2FjrOgHGt5j9QXrw6bZAG2Ask/eERk=
MIME-Version: 1.0
In-Reply-To: <af473935-7cb6-e59a-3b52-055d8492248c@st.com>
References: <af473935-7cb6-e59a-3b52-055d8492248c@st.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 15 Mar 2018 15:59:31 +0100
X-Google-Sender-Auth: HdNpfCm1X0l-XvOtWLKylyoNf7w
Message-ID: <CAK8P3a1R6CwHC4+0GXKevmgM9QqgbGGZCtLsccn2AYTpuHZ7uw@mail.gmail.com>
Subject: Re: [GIT PULL] STi DT update for v4.17 round 2
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

On Thu, Mar 15, 2018 at 10:06 AM, Patrice CHOTARD
<patrice.chotard@st.com> wrote:
> Hi Arnd, Kevin, Olof
>
> PLease consider this second round of STi dts update for v4.17
>
> The following changes since commit 0e04ce02e6a2ac30d21294d8bb2aeceb8489e52b:
>
>    ARM: dts: STi: Remove unused clk_ext2f_a9 clock (2018-02-13 13:31:38
> +0100)
>
> are available in the git repository at:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/pchotard/sti.git
>
> for you to fetch changes up to 9a5f4879cd8de167e82f335317c63f2ffdc80129:
>
>    ARM: dts: stih4xx: Add missing #sound-dai-cells (2018-03-15 09:52:25
> +0100)
>
> ----------------------------------------------------------------
>
> STi DT update:
>
> Add missing #sound-dai-cells which fix DT dtc warnings when building
> with W=1

You missed a tag name for this one, but I found tags/sti-dt-for-v4.17-round2
to be the one that matches the commit ID above and pulled that.

      Arnd
