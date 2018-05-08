Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933051AbeEHIVT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 04:21:19 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:44490 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932996AbeEHIVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 04:21:16 -0400
X-Google-Smtp-Source: AB8JxZokQuEJMcT4wuPSGEvw9WQcE2ryJTv8nngdrmtwAb1B9VvqTaJSz8mBTDfB1wu1jLwxDq8jwjkVv8Qinu9ZcWg=
MIME-Version: 1.0
In-Reply-To: <20180410134822.23990-1-anders.roxell@linaro.org>
References: <20180410134822.23990-1-anders.roxell@linaro.org>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Tue, 8 May 2018 10:21:14 +0200
Message-ID: <CADYN=9L-CBLjG=mtOOfzBC4EZt02idZKgnrj5bSvsfPVSFZpsg@mail.gmail.com>
Subject: Re: [PATCH] selftests: kvm: add .gitignore for generated files
To: Shuah Khan <shuah@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 April 2018 at 15:48, Anders Roxell <anders.roxell@linaro.org> wrote:
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  tools/testing/selftests/kvm/.gitignore | 2 ++
>  1 file changed, 2 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/.gitignore
>
> diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
> new file mode 100644
> index 000000000000..a546e052d19a
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/.gitignore
> @@ -0,0 +1,2 @@
> +set_sregs_test
> +sync_regs_test
> --
> 2.16.3
>

ping.
