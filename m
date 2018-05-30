Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751949AbeE3KCf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 06:02:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56114 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751778AbeE3KCb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 06:02:31 -0400
Date: Wed, 30 May 2018 12:03:19 +0200
From: Eugene Syromiatnikov <esyr@redhat.com>
To: Song Liu <liu.song.a23@gmail.com>
Cc: netdev@vger.kernel.org, open list <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>, Jiri Olsa <jolsa@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Lawrence Brakmo <brakmo@fb.com>,
        Andrey Ignatov <rdna@fb.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        John Fastabend <john.fastabend@gmail.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>
Subject: Re: [PATCH bpf 2/2] bpf: enforce usage of __aligned_u64 in the UAPI
 header
Message-ID: <20180530100319.GB5378@asgard.redhat.com>
References: <20180527112847.GA18311@asgard.redhat.com>
 <CAPhsuW5fVamngrqEWcsPKyr3Njjz4K5vO3o51BuWXAMw_nf9KA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhsuW5fVamngrqEWcsPKyr3Njjz4K5vO3o51BuWXAMw_nf9KA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 10:35:09AM -0700, Song Liu wrote:
> I think these changes are not necessary. Is it a general guidance to
> only use 64-bit aligned
> variables in UAPI headers?

Not really, but it allows avoiding most alignment issues like the one
mentioned in the previous patch and in the referenced RDMA patch.
