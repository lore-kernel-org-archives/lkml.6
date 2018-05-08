Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933117AbeEHIWX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 04:22:23 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:43772 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932921AbeEHIWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 04:22:18 -0400
X-Google-Smtp-Source: AB8JxZrjGnshFUHoZgtDBaGANFFMddup5QuEW3wCnhGE+IvVzcKVjh13DhqbnOEoTlkEqWtfCL6YarwaH9Z7+AzgYdE=
MIME-Version: 1.0
In-Reply-To: <20180423135725.3753-1-anders.roxell@linaro.org>
References: <20180423135725.3753-1-anders.roxell@linaro.org>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Tue, 8 May 2018 10:22:17 +0200
Message-ID: <CADYN=9KPSYmrAA_N-J-OLvn2+B1_hU5KK24-Q1V66j3cCmkNTw@mail.gmail.com>
Subject: Re: [PATCH] selftests: kvm: update .gitignore with missing file
To: Shuah Khan <shuah@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kselftest@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 April 2018 at 15:57, Anders Roxell <anders.roxell@linaro.org> wrote:
> Fixes: d5edb7f8e7ab ("kvm: selftests: add vmx_tsc_adjust_test")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  tools/testing/selftests/kvm/.gitignore | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
> index a546e052d19a..63fc1ab9248f 100644
> --- a/tools/testing/selftests/kvm/.gitignore
> +++ b/tools/testing/selftests/kvm/.gitignore
> @@ -1,2 +1,3 @@
>  set_sregs_test
>  sync_regs_test
> +vmx_tsc_adjust_test
> --
> 2.17.0
>

ping.
