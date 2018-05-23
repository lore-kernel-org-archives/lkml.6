Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753903AbeEWDf5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 23:35:57 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:34166 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753165AbeEWDfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 23:35:55 -0400
X-Google-Smtp-Source: AB8JxZoRuEe/qoAnXJJRAg+6d0OmGKGnUqGRe7X4Mt2GZ44d/m0hKUPvRDNgUNjcd8ndFUJ3qmmVHw==
Date: Tue, 22 May 2018 20:35:51 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Y Song <ys114321@gmail.com>
Cc: Alban Crequy <alban.crequy@gmail.com>, netdev <netdev@vger.kernel.org>,
        linux-kernel@vger.kernel.org, containers@lists.linux-foundation.org,
        cgroups@vger.kernel.org, Alban Crequy <alban@kinvolk.io>,
        tj@kernel.org
Subject: Re: [PATCH] [RFC] bpf: tracing: new helper bpf_get_current_cgroup_ino
Message-ID: <20180523033550.z3tqo4lhd3zrmtdu@ast-mbp>
References: <20180513173318.21680-1-alban@kinvolk.io>
 <20180521162609.lpdrnozowmzdn57m@ast-mbp.dhcp.thefacebook.com>
 <CAH3MdRWgruVq+3r+2pHTah-c2zTO03vPkepjWDZ0_KrYcroy9A@mail.gmail.com>
 <CAH3MdRVdfw52atavT3KL8MpPw7zDM_hR6aUcqDP1PogLn_sH+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH3MdRVdfw52atavT3KL8MpPw7zDM_hR6aUcqDP1PogLn_sH+w@mail.gmail.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2018 at 08:33:24PM -0700, Y Song wrote:
> +       struct cgroup *cgrp = task_dfl_cgroup(current);
> +       if (!cgrp)
> +               return -EINVAL;

why this check is needed?
