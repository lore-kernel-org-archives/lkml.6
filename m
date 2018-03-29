Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752077AbeC2TcB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 15:32:01 -0400
Received: from mail-ot0-f178.google.com ([74.125.82.178]:45285 "EHLO
        mail-ot0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751096AbeC2TcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 15:32:00 -0400
X-Google-Smtp-Source: AIpwx49giy9ZvKgz3z4C8ZPE3AZbJP8O1Ohsoyi0t7gNxAmuh6miiH1EdZtswaNoa8zYHjcwnWHzxlwnNjm0qwNypDY=
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1803292109180.2750@hadrien>
References: <alpine.DEB.2.20.1803292109180.2750@hadrien>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 29 Mar 2018 16:31:58 -0300
Message-ID: <CAOMZO5CLpW+2yCYRwAJTPWtXgXkaPGyPQrB3cbBGYvV1fryUQw@mail.gmail.com>
Subject: Re: [kbuild-all] [PATCH] OPTIONAL: cpufreq/intel_pstate: fix
 debugfs_simple_attr.cocci warnings
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: Francisco Jerez <currojerez@riseup.net>, linux-pm@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel <linux-kernel@vger.kernel.org>, kbuild-all@01.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        0day robot <fengguang.wu@intel.com>, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Julia,

On Thu, Mar 29, 2018 at 4:12 PM, Julia Lawall <julia.lawall@lip6.fr> wrote:
>  Use DEFINE_DEBUGFS_ATTRIBUTE rather than DEFINE_SIMPLE_ATTRIBUTE
>  for debugfs files.
>
> Semantic patch information:
>  Rationale: DEFINE_SIMPLE_ATTRIBUTE + debugfs_create_file()
>  imposes some significant overhead as compared to
>  DEFINE_DEBUGFS_ATTRIBUTE + debugfs_create_file_unsafe().

Just curious: could you please expand on what "imposes some
significant overhead" means?

Thanks
