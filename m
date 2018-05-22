Return-Path: <mathieu.poirier@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1527011619; cv=none;
        d=google.com; s=arc-20160816;
        b=SIaO4uxwSrmu208wD3JnDarnpiKHxcdHiB0TNu577UxxXo8yiVLqNc+9hqEY41hKXe
         cUtbjX2IDp3pB1gUSzRUcfGFJfBoewAJQDPnLXA9//lLPp6YoB7qN0/f4aWjfA7CI8i8
         AxO4CVoewG95iDINuYuYUMCpNsuxGMEY3iN23IWIeP3z10tYriYanSy9B1BQbeg6qSQy
         8akC/p5S+3WIVFbbb0kPxKdDm4hIt0cBrcCeUgpo7swdy0Cfid6QYjg9Vrba3iv0xN9Y
         d3rqBgVtQBsAh8bsFfYGtb0Q1p8rFWGCs78ZQcHVz5jcup33ETP3Ahxl+DaEQ41XyUFO
         sh+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=ewQG30iL4HuotzTJdE/o0HrJN6ERGHKrCHZSzQe5T60=;
        b=gknvW8tBZ998jYC8UBjSa9j/6yjVl6rbpDuLVzADQdXF2E8QHJDf+jnbS1JEGg94X8
         ihMXWiUV7E0oXejYViwAnO+vTif8woXO+BCj5lo1mq7sqVOfbUbh7903M5VizYs9let/
         EIUWz2A/EpS9lgq5eQqjG6zQkMBsnRasu9/d26GXk1Ch59P6nf4wPztai7cSi8XmmjJP
         RdciQTOg2RjC8RBtoOndJ1mT5aj4gkHuN8tH9dJSxfz9OhMeU+C70kpPX52hZLLZm6t2
         oLLfUvqBipe5n6MjUrHRIkouw9S44x7YPg9EgPINc4uc8Yw7L+BVOvZdDaYs7yEDTGJu
         R3Ew==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=CWHsu6Dt;
       spf=pass (google.com: domain of mathieu.poirier@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=mathieu.poirier@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=CWHsu6Dt;
       spf=pass (google.com: domain of mathieu.poirier@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=mathieu.poirier@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZoNtzCkwII7xwW3YhPORxuoCspGL9Rr4a0JIDJ98ea6G16kyDUco7Fm9q3Swvhqw/WhOJClFA==
Date: Tue, 22 May 2018 11:53:34 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Kim Phillips <kim.phillips@arm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Howells <dhowells@redhat.com>,
	Eric Auger <eric.auger@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Gargi Sharma <gs051095@gmail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Kirill Tkhai <ktkhai@virtuozzo.com>,
	Mike Rapoport <rppt@linux.vnet.ibm.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Pavel Tatashin <pasha.tatashin@oracle.com>,
	Rik van Riel <riel@redhat.com>, Robin Murphy <robin.murphy@arm.com>,
	Russell King <linux@armlinux.org.uk>,
	Thierry Reding <treding@nvidia.com>, Todd Kjos <tkjos@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] coresight: populate MODULE_AUTHOR, DESCRIPTION, and
 LICENSEs
Message-ID: <20180522175334.GB25658@xps15>
References: <20180517070643.GC13919@kroah.com>
 <20180518012024.22645-1-kim.phillips@arm.com>
 <20180518012024.22645-5-kim.phillips@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518012024.22645-5-kim.phillips@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600762905490701914?=
X-GMAIL-MSGID: =?utf-8?q?1601187735681649882?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 17, 2018 at 08:20:23PM -0500, Kim Phillips wrote:
> Necessary prior to enabling to be built as modules.
> 
> Signed-off-by: Kim Phillips <kim.phillips@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-dynamic-replicator.c | 4 ++++
>  drivers/hwtracing/coresight/coresight-etb10.c              | 5 +++++
>  drivers/hwtracing/coresight/coresight-etm-cp14.c           | 4 ++++
>  drivers/hwtracing/coresight/coresight-etm-perf.c           | 4 ++++
>  drivers/hwtracing/coresight/coresight-etm3x-sysfs.c        | 5 +++++
>  drivers/hwtracing/coresight/coresight-etm3x.c              | 5 +++++
>  drivers/hwtracing/coresight/coresight-etm4x-sysfs.c        | 4 ++++
>  drivers/hwtracing/coresight/coresight-etm4x.c              | 5 +++++
>  drivers/hwtracing/coresight/coresight-funnel.c             | 4 ++++
>  drivers/hwtracing/coresight/coresight-replicator.c         | 5 +++++
>  drivers/hwtracing/coresight/coresight-stm.c                | 4 ++++
>  drivers/hwtracing/coresight/coresight-tmc-etf.c            | 4 ++++
>  drivers/hwtracing/coresight/coresight-tmc-etr.c            | 4 ++++
>  drivers/hwtracing/coresight/coresight-tmc.c                | 4 ++++
>  drivers/hwtracing/coresight/coresight-tpiu.c               | 5 +++++
>  drivers/hwtracing/coresight/coresight.c                    | 4 ++++
>  16 files changed, 70 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-dynamic-replicator.c b/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
> index f6d0571ab9dd..fc742215ab05 100644
> --- a/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
> +++ b/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
> @@ -210,3 +210,7 @@ static struct amba_driver replicator_driver = {
>  	.id_table	= replicator_ids,
>  };
>  builtin_amba_driver(replicator_driver);
> +
> +MODULE_AUTHOR("Pratik Patel <pratikp@codeaurora.org>");
> +MODULE_DESCRIPTION("ARM Coresight Dynamic Replicator Driver");

s/ARM/Arm
s/Coresight/CoreSight

> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
> index 9b6c55523c58..a3dac5a8b37c 100644
> --- a/drivers/hwtracing/coresight/coresight-etb10.c
> +++ b/drivers/hwtracing/coresight/coresight-etb10.c
> @@ -758,3 +758,8 @@ static struct amba_driver etb_driver = {
>  	.id_table	= etb_ids,
>  };
>  builtin_amba_driver(etb_driver);
> +
> +MODULE_AUTHOR("Pratik Patel <pratikp@codeaurora.org>");
> +MODULE_AUTHOR("Mathieu Poirier <mathieu.poirier@linaro.org>");
> +MODULE_DESCRIPTION("Arm CoreSight Embedded Trace Buffer driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/hwtracing/coresight/coresight-etm-cp14.c b/drivers/hwtracing/coresight/coresight-etm-cp14.c
> index 4174a8d355d2..68ca423aa088 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-cp14.c
> +++ b/drivers/hwtracing/coresight/coresight-etm-cp14.c
> @@ -582,3 +582,7 @@ int etm_writel_cp14(u32 reg, u32 val)
>  
>  	return 0;
>  }
> +
> +MODULE_AUTHOR("Pratik Patel <pratikp@codeaurora.org>");
> +MODULE_DESCRIPTION("Arm CoreSight ETM CP14 driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> index 677695635211..ad0ef8d27111 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> @@ -494,3 +494,7 @@ static int __init etm_perf_init(void)
>  	return ret;
>  }
>  device_initcall(etm_perf_init);
> +
> +MODULE_AUTHOR("Mathieu Poirier <mathieu.poirier@linaro.org>");
> +MODULE_DESCRIPTION("Arm CoreSight tracer perf driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> index 75487b3fad86..91a2a23143d8 100644
> --- a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> @@ -1294,3 +1294,8 @@ const struct attribute_group *coresight_etm_groups[] = {
>  	&coresight_etm_mgmt_group,
>  	NULL,
>  };
> +
> +MODULE_AUTHOR("Pratik Patel <pratikp@codeaurora.org>");
> +MODULE_AUTHOR("Mathieu Poirier <mathieu.poirier@linaro.org>");
> +MODULE_DESCRIPTION("Arm CoreSight Program Flow Trace sysfs driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
> index 7c74263c333d..7ca73a15c735 100644
> --- a/drivers/hwtracing/coresight/coresight-etm3x.c
> +++ b/drivers/hwtracing/coresight/coresight-etm3x.c
> @@ -935,3 +935,8 @@ static struct amba_driver etm_driver = {
>  	.id_table	= etm_ids,
>  };
>  builtin_amba_driver(etm_driver);
> +
> +MODULE_AUTHOR("Pratik Patel <pratikp@codeaurora.org>");
> +MODULE_AUTHOR("Mathieu Poirier <mathieu.poirier@linaro.org>");
> +MODULE_DESCRIPTION("Arm CoreSight Program Flow Trace driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> index a0365e23678e..577a38673444 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> @@ -2173,3 +2173,7 @@ const struct attribute_group *coresight_etmv4_groups[] = {
>  	&coresight_etmv4_trcidr_group,
>  	NULL,
>  };
> +
> +MODULE_AUTHOR("Mathieu Poirier <mathieu.poirier@linaro.org>");
> +MODULE_DESCRIPTION("Arm CoreSight Program Flow Trace v4 sysfs driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
> index 9bc04c50d45b..ba10f5302a55 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.c
> @@ -1073,3 +1073,8 @@ static struct amba_driver etm4x_driver = {
>  	.id_table	= etm4_ids,
>  };
>  builtin_amba_driver(etm4x_driver);
> +
> +MODULE_AUTHOR("Pratik Patel <pratikp@codeaurora.org>");
> +MODULE_AUTHOR("Mathieu Poirier <mathieu.poirier@linaro.org>");
> +MODULE_DESCRIPTION("Arm CoreSight Program Flow Trace v4 driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
> index 448145a36675..1e497a75b956 100644
> --- a/drivers/hwtracing/coresight/coresight-funnel.c
> +++ b/drivers/hwtracing/coresight/coresight-funnel.c
> @@ -261,3 +261,7 @@ static struct amba_driver funnel_driver = {
>  	.id_table	= funnel_ids,
>  };
>  builtin_amba_driver(funnel_driver);
> +
> +MODULE_AUTHOR("Mathieu Poirier <mathieu.poirier@linaro.org>");
> +MODULE_DESCRIPTION("ARM Coresight Funnel Driver");

s/ARM/Arm
s/Coresight/CoreSight

> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
> index 8d2eaaab6c2f..9ef539893eaa 100644
> --- a/drivers/hwtracing/coresight/coresight-replicator.c
> +++ b/drivers/hwtracing/coresight/coresight-replicator.c
> @@ -154,3 +154,8 @@ static struct platform_driver replicator_driver = {
>  	},
>  };
>  builtin_platform_driver(replicator_driver);
> +
> +MODULE_AUTHOR("Pratik Patel <pratikp@codeaurora.org>");
> +MODULE_AUTHOR("Mathieu Poirier <mathieu.poirier@linaro.org>");
> +MODULE_DESCRIPTION("ARM Coresight Replicator Driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
> index c46c70aec1d5..30eae52a8757 100644
> --- a/drivers/hwtracing/coresight/coresight-stm.c
> +++ b/drivers/hwtracing/coresight/coresight-stm.c
> @@ -934,3 +934,7 @@ static struct amba_driver stm_driver = {
>  };
>  
>  builtin_amba_driver(stm_driver);
> +
> +MODULE_AUTHOR("Pratik Patel <pratikp@codeaurora.org>");
> +MODULE_DESCRIPTION("Arm CoreSight System Trace Macrocell driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> index 61d849b11c26..94cd6c00fcc9 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> @@ -617,3 +617,7 @@ int tmc_read_unprepare_etb(struct tmc_drvdata *drvdata)
>  
>  	return 0;
>  }
> +
> +MODULE_AUTHOR("Pratik Patel <pratikp@codeaurora.org>");
> +MODULE_DESCRIPTION("Arm CoreSight Trace Memory Controller ETB/ETF mode driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> index 02f747afa2ba..e612896e92a7 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> @@ -330,3 +330,7 @@ int tmc_read_unprepare_etr(struct tmc_drvdata *drvdata)
>  
>  	return 0;
>  }
> +
> +MODULE_AUTHOR("Pratik Patel <pratikp@codeaurora.org>");
> +MODULE_DESCRIPTION("Arm CoreSight Trace Memory Controller ETR mode driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
> index 456f122df74f..176a5aeab20e 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc.c
> @@ -463,3 +463,7 @@ static struct amba_driver tmc_driver = {
>  	.id_table	= tmc_ids,
>  };
>  builtin_amba_driver(tmc_driver);
> +
> +MODULE_AUTHOR("Pratik Patel <pratikp@codeaurora.org>");
> +MODULE_DESCRIPTION("Arm CoreSight Trace Memory Controller driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
> index 01b7457fe8fc..f3b154e150b3 100644
> --- a/drivers/hwtracing/coresight/coresight-tpiu.c
> +++ b/drivers/hwtracing/coresight/coresight-tpiu.c
> @@ -218,3 +218,8 @@ static struct amba_driver tpiu_driver = {
>  	.id_table	= tpiu_ids,
>  };
>  builtin_amba_driver(tpiu_driver);
> +
> +MODULE_AUTHOR("Pratik Patel <pratikp@codeaurora.org>");
> +MODULE_AUTHOR("Mathieu Poirier <mathieu.poirier@linaro.org>");
> +MODULE_DESCRIPTION("Arm CoreSight TPIU (Trace Port Interface Unit) driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
> index 0cbc2948defc..406899f316e4 100644
> --- a/drivers/hwtracing/coresight/coresight.c
> +++ b/drivers/hwtracing/coresight/coresight.c
> @@ -1041,3 +1041,7 @@ void coresight_unregister(struct coresight_device *csdev)
>  	device_unregister(&csdev->dev);
>  }
>  EXPORT_SYMBOL_GPL(coresight_unregister);
> +
> +MODULE_AUTHOR("Mathieu Poirier <mathieu.poirier@linaro.org>");
> +MODULE_DESCRIPTION("ARM Coresight Driver");

s/ARM/Arm
s/Coresight/CoreSight

> +MODULE_LICENSE("GPL v2");
> -- 
> 2.17.0
> 
