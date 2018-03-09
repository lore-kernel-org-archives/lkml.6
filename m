Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932089AbeCIQAm (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 11:00:42 -0500
Received: from mout.web.de ([217.72.192.78]:55911 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751096AbeCIQAk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 11:00:40 -0500
Subject: [PATCH v2 0/3] mfd/abx500-core: Adjustments for eight function
 implementations
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <c5d9751e-3ae8-0b66-821a-0e7f45bb8e1c@users.sourceforge.net>
Message-ID: <6c8ff539-9e9d-635b-22a8-df8100ac8156@users.sourceforge.net>
Date: Fri, 9 Mar 2018 17:00:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <c5d9751e-3ae8-0b66-821a-0e7f45bb8e1c@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:NGBKmL4BUjiNaO6kHDu03gCOIkXqx2I0igdasfxcS+q/byilJuQ
 o3MXCH8wI/RMl/8xJFrFPUuMZ9WYDf4QOFUGymO0ksyRB3BfoZpPCLirmoXpp1I7OL2qbDD
 1McS+HJ7clzX3IGPS9p/+9VOsucksrXbvmSRujxBIpoePS6Sb+h5ej3GlfzIhVtzGmiSfiP
 QvNfPtIfSiYvJ1qV8QNwA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4FK06a/2FQg=:QmnDTH2N2JCBnKiTKNdUgD
 2DAx3n7sD4Ml7vn4Tc39AwrIv98ir+2Hx5ZKltkC00/33H090tIbE3UbEULcDzXWGpmqz+PhS
 7X6hkke145AO8qQ2yFKPzGppEchNemCeu+OLHbKEagFYyqfE8yUgkJNcmDH0E3sKojUC6bje4
 lgis7nr+IreoPO3PZrwKFscfAshhBaz8q6P/pJa3SjCqZGOzVYs8cFn5X69xSDxkdSUJ86n3S
 Nzn6UqUdRFmYEm8JXVazf5OII2AV9w0modJvzPB50ULcd2QoLNelC/UgEvaHREp7J2g0F+5Ag
 P/373vVGD0ju94aQ2jakukZ9nPUpC940oA9KkoPJkJMCbhJ2RLNjgVJ2u6FlYNQDUaKwbweKh
 2RBg2LQA+m+rXfP3B6StFr9Z1NlR580f0mSDBu0yf6p4h0auHaHwO4NhQzAidt4jkuy3lCV87
 /KOIz3JOAHyPskvXG43S0N0qA0u3bfF8jh825vf/mrLaQ2oxlg4J13bpVfBwIGaZQZ+Jc5WR6
 PtUjw7CMkqs2QHdcMqtMwHXCxjZbmZJ1avODVXesEebr0yBWMKHCbEy7X38HdaV0MelCuxEny
 W0nZToge9RvHXCZoGbrScKM8L4b+LRcxxAhCtbiFn4GURHYPv6FIIOm243ukDEBJOOUlDaNPj
 BnmC8xf2pYMcJ7lYjrq3FUXwLWvaTiCoKV5za+1IGafQ4h4yrUNmRxYvyaja5cXyUkIZUZeQ+
 qK4/o24JCX+p2Q3c6L5KNekmwq7Vb8t76dSMsDodiP332jceXm3BBQgM4b0gqPqvdrLPCoiK/
 Ut0pyvCgpZe/AChuwk1g5r+hMWo9Z2imlsxU8WcAJgCbwytE7I=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>

Three update suggestions were taken into account
from static source code analysis.

Markus Elfring (3):
  Delete an error message for a failed memory allocation
    in abx500_register_ops()
  Improve two size determinations in abx500_register_ops()
  Adjust 14 checks for null pointers

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---

v2:
Lee Jones requested a resend for these patches. The changes were rebased
on source files from Linux next-20180308.

 drivers/mfd/abx500-core.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

-- 
2.15.1
