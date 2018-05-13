Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751899AbeEMJPX (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 05:15:23 -0400
Received: from lb3-smtp-cloud8.xs4all.net ([194.109.24.29]:37576 "EHLO
        lb3-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751227AbeEMJPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 05:15:22 -0400
Subject: Re: [PATCH 3/5] media: docs: selection: rename files to something
 meaningful
To: Luca Ceresoli <luca@lucaceresoli.net>, linux-media@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org
References: <1522790146-16061-1-git-send-email-luca@lucaceresoli.net>
 <1522790146-16061-3-git-send-email-luca@lucaceresoli.net>
From: Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <a343a036-3caf-865c-89e9-8db42ea9063a@xs4all.nl>
Date: Sun, 13 May 2018 11:15:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1522790146-16061-3-git-send-email-luca@lucaceresoli.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfNdadfRR9oDhSaeowgwnTvzFcX/EarMDnFifO0mogknh57fSYJY3bgmBFylfHIiACX6j9cKS0Yb541Pa+RA0VQqYHWFlZ4vmjf0qUVJgyvMouudTR8Bs
 7m3qHj8bM4gtgraOp//Ks1XaGqXbo7Hw1+Q8OZM9etuf+9p+KvwlQLvm/k2YZcjgFKWbd2OX4wvcITs/4E0HgQf1enbq6LhsKSscteK3UCeUMB3PxMusAfkP
 nVLnRg1YCuum9hrz5mCvKfCnBH5WC8CiFFdrY5dMqOs=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/03/2018 11:15 PM, Luca Ceresoli wrote:
> These files have an automatically-generated numbering. Replaname them

Replaname -> Replace

> to something that suggests their meaning.

to -> with

Regards,

	Hans

> 
> Reported-by: Hans Verkuil <hverkuil@xs4all.nl>
> Cc: Hans Verkuil <hverkuil@xs4all.nl>
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> ---
>  .../{selection-api-004.rst => selection-api-configuration.rst} |  0
>  .../v4l/{selection-api-006.rst => selection-api-examples.rst}  |  0
>  .../v4l/{selection-api-002.rst => selection-api-intro.rst}     |  0
>  .../v4l/{selection-api-003.rst => selection-api-targets.rst}   |  0
>  .../{selection-api-005.rst => selection-api-vs-crop-api.rst}   |  0
>  Documentation/media/uapi/v4l/selection-api.rst                 | 10 +++++-----
>  6 files changed, 5 insertions(+), 5 deletions(-)
>  rename Documentation/media/uapi/v4l/{selection-api-004.rst => selection-api-configuration.rst} (100%)
>  rename Documentation/media/uapi/v4l/{selection-api-006.rst => selection-api-examples.rst} (100%)
>  rename Documentation/media/uapi/v4l/{selection-api-002.rst => selection-api-intro.rst} (100%)
>  rename Documentation/media/uapi/v4l/{selection-api-003.rst => selection-api-targets.rst} (100%)
>  rename Documentation/media/uapi/v4l/{selection-api-005.rst => selection-api-vs-crop-api.rst} (100%)
> 
> diff --git a/Documentation/media/uapi/v4l/selection-api-004.rst b/Documentation/media/uapi/v4l/selection-api-configuration.rst
> similarity index 100%
> rename from Documentation/media/uapi/v4l/selection-api-004.rst
> rename to Documentation/media/uapi/v4l/selection-api-configuration.rst
> diff --git a/Documentation/media/uapi/v4l/selection-api-006.rst b/Documentation/media/uapi/v4l/selection-api-examples.rst
> similarity index 100%
> rename from Documentation/media/uapi/v4l/selection-api-006.rst
> rename to Documentation/media/uapi/v4l/selection-api-examples.rst
> diff --git a/Documentation/media/uapi/v4l/selection-api-002.rst b/Documentation/media/uapi/v4l/selection-api-intro.rst
> similarity index 100%
> rename from Documentation/media/uapi/v4l/selection-api-002.rst
> rename to Documentation/media/uapi/v4l/selection-api-intro.rst
> diff --git a/Documentation/media/uapi/v4l/selection-api-003.rst b/Documentation/media/uapi/v4l/selection-api-targets.rst
> similarity index 100%
> rename from Documentation/media/uapi/v4l/selection-api-003.rst
> rename to Documentation/media/uapi/v4l/selection-api-targets.rst
> diff --git a/Documentation/media/uapi/v4l/selection-api-005.rst b/Documentation/media/uapi/v4l/selection-api-vs-crop-api.rst
> similarity index 100%
> rename from Documentation/media/uapi/v4l/selection-api-005.rst
> rename to Documentation/media/uapi/v4l/selection-api-vs-crop-api.rst
> diff --git a/Documentation/media/uapi/v4l/selection-api.rst b/Documentation/media/uapi/v4l/selection-api.rst
> index e4e623824b30..390233f704a3 100644
> --- a/Documentation/media/uapi/v4l/selection-api.rst
> +++ b/Documentation/media/uapi/v4l/selection-api.rst
> @@ -9,8 +9,8 @@ Cropping, composing and scaling -- the SELECTION API
>  .. toctree::
>      :maxdepth: 1
>  
> -    selection-api-002
> -    selection-api-003
> -    selection-api-004
> -    selection-api-005
> -    selection-api-006
> +    selection-api-intro.rst
> +    selection-api-targets.rst
> +    selection-api-configuration.rst
> +    selection-api-vs-crop-api.rst
> +    selection-api-examples.rst
> 
