Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933181AbeEHQ5r (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 12:57:47 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37842 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932368AbeEHQ5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 12:57:46 -0400
X-Google-Smtp-Source: AB8JxZrRAu5GIx56kiNck38pXk31g7vOHYmkA9Fk3cFndDMoP3VpDPNMelt0g620T7C6OmsfNPjc6A0uG+oVcpTzrRA=
MIME-Version: 1.0
In-Reply-To: <1525360703-26159-2-git-send-email-leo.yan@linaro.org>
References: <1525360703-26159-1-git-send-email-leo.yan@linaro.org> <1525360703-26159-2-git-send-email-leo.yan@linaro.org>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Tue, 8 May 2018 10:57:44 -0600
Message-ID: <CANLsYkw9Yk1HWHrmpVDLMFFPrk+1urk39=Em4hU=XG323LHh5Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf cs-etm: Remove redundant space
To: Leo Yan <leo.yan@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 May 2018 at 09:18, Leo Yan <leo.yan@linaro.org> wrote:
> There have two spaces ahead function name cs_etm__set_pid_tid_cpu(), so
> remove one space and correct indentation.
>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> ---
>  tools/perf/util/cs-etm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 417302c..3137fbe 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -612,8 +612,8 @@ cs_etm__get_trace(struct cs_etm_buffer *buff, struct cs_etm_queue *etmq)
>         return buff->len;
>  }
>
> -static void  cs_etm__set_pid_tid_cpu(struct cs_etm_auxtrace *etm,
> -                                    struct auxtrace_queue *queue)
> +static void cs_etm__set_pid_tid_cpu(struct cs_etm_auxtrace *etm,
> +                                   struct auxtrace_queue *queue)
>  {
>         struct cs_etm_queue *etmq = queue->priv;
>
> --
> 2.7.4
>
