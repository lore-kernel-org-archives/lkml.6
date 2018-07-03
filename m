Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B00EC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13B5F244F5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:35:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13B5F244F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933259AbeGCGfA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 02:35:00 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48040 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932646AbeGCGe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 02:34:58 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9C8A8E25;
        Tue,  3 Jul 2018 06:34:57 +0000 (UTC)
Date:   Tue, 3 Jul 2018 08:34:54 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Peter Vernia <peter.vernia@gmail.com>
Cc:     devel@driverdev.osuosl.org, Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, NeilBrown <neil@brown.name>,
        Christian =?iso-8859-1?Q?L=FCtke-Stetzkamp?= <christian@lkamp.de>,
        dan.carpenter@oracle.com, John Crispin <blogic@openwrt.org>
Subject: Re: [PATCH] staging: mt7621-pinctrl: Style fixes to pinctrl-rt2880
Message-ID: <20180703063454.GA21905@kroah.com>
References: <1530595253-6539-1-git-send-email-peter.vernia@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530595253-6539-1-git-send-email-peter.vernia@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 01:20:47AM -0400, Peter Vernia wrote:
> Replaces instances of "unsigned" with "unsigned int"; fixes comma and tab
> spacing.
> 
> Signed-off-by: Peter Vernia <peter.vernia@gmail.com>
> ---
>  drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c | 35 +++++++++++++------------
>  1 file changed, 18 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c b/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c
> index 0c3e498..6894510 100644
> --- a/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c
> +++ b/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c
> @@ -54,7 +54,7 @@ static int rt2880_get_group_count(struct pinctrl_dev *pctrldev)
>  }
>  
>  static const char *rt2880_get_group_name(struct pinctrl_dev *pctrldev,
> -					 unsigned group)
> +					 unsigned int group)
>  {
>  	struct rt2880_priv *p = pinctrl_dev_get_drvdata(pctrldev);
>  
> @@ -65,9 +65,9 @@ static const char *rt2880_get_group_name(struct pinctrl_dev *pctrldev,
>  }
>  
>  static int rt2880_get_group_pins(struct pinctrl_dev *pctrldev,
> -				 unsigned group,
> -				 const unsigned **pins,
> -				 unsigned *num_pins)
> +				 unsigned int group,
> +				 const unsigned int **pins,
> +				 unsigned int *num_pins)
>  {
>  	struct rt2880_priv *p = pinctrl_dev_get_drvdata(pctrldev);
>  
> @@ -81,7 +81,8 @@ static int rt2880_get_group_pins(struct pinctrl_dev *pctrldev,
>  }
>  
>  static void rt2880_pinctrl_dt_free_map(struct pinctrl_dev *pctrldev,
> -				    struct pinctrl_map *map, unsigned num_maps)
> +				    struct pinctrl_map *map,
> +				    unsigned int num_maps)
>  {
>  	int i;
>  
> @@ -94,7 +95,7 @@ static void rt2880_pinctrl_dt_free_map(struct pinctrl_dev *pctrldev,
>  
>  static void rt2880_pinctrl_pin_dbg_show(struct pinctrl_dev *pctrldev,
>  					struct seq_file *s,
> -					unsigned offset)
> +					unsigned int offset)
>  {
>  	seq_printf(s, "ralink pio");
>  }
> @@ -103,7 +104,7 @@ static void rt2880_pinctrl_dt_subnode_to_map(struct pinctrl_dev *pctrldev,
>  				struct device_node *np,
>  				struct pinctrl_map **map)
>  {
> -        const char *function;
> +	const char *function;
>  	int func = of_property_read_string(np, "ralink,function", &function);
>  	int grps = of_property_count_strings(np, "ralink,group");
>  	int i;
> @@ -112,7 +113,7 @@ static void rt2880_pinctrl_dt_subnode_to_map(struct pinctrl_dev *pctrldev,
>  		return;
>  
>  	for (i = 0; i < grps; i++) {
> -	        const char *group;
> +		const char *group;
>  
>  		of_property_read_string_index(np, "ralink,group", i, &group);
>  
> @@ -127,7 +128,7 @@ static void rt2880_pinctrl_dt_subnode_to_map(struct pinctrl_dev *pctrldev,
>  static int rt2880_pinctrl_dt_node_to_map(struct pinctrl_dev *pctrldev,
>  				struct device_node *np_config,
>  				struct pinctrl_map **map,
> -				unsigned *num_maps)
> +				unsigned int *num_maps)
>  {
>  	int max_maps = 0;
>  	struct pinctrl_map *tmp;
> @@ -173,7 +174,7 @@ static int rt2880_pmx_func_count(struct pinctrl_dev *pctrldev)
>  }
>  
>  static const char *rt2880_pmx_func_name(struct pinctrl_dev *pctrldev,
> -					 unsigned func)
> +					 unsigned int func)
>  {
>  	struct rt2880_priv *p = pinctrl_dev_get_drvdata(pctrldev);
>  
> @@ -181,7 +182,7 @@ static const char *rt2880_pmx_func_name(struct pinctrl_dev *pctrldev,
>  }
>  
>  static int rt2880_pmx_group_get_groups(struct pinctrl_dev *pctrldev,
> -				unsigned func,
> +				unsigned int func,
>  				const char * const **groups,
>  				unsigned * const num_groups)
>  {
> @@ -198,11 +199,11 @@ static int rt2880_pmx_group_get_groups(struct pinctrl_dev *pctrldev,
>  }
>  
>  static int rt2880_pmx_group_enable(struct pinctrl_dev *pctrldev,
> -				unsigned func,
> -				unsigned group)
> +				unsigned int func,
> +				unsigned int group)
>  {
>  	struct rt2880_priv *p = pinctrl_dev_get_drvdata(pctrldev);
> -        u32 mode = 0;
> +	u32 mode = 0;
>  	u32 reg = SYSC_REG_GPIO_MODE;
>  	int i;
>  	int shift;
> @@ -243,7 +244,7 @@ static int rt2880_pmx_group_enable(struct pinctrl_dev *pctrldev,
>  
>  static int rt2880_pmx_group_gpio_request_enable(struct pinctrl_dev *pctrldev,
>  				struct pinctrl_gpio_range *range,
> -				unsigned pin)
> +				unsigned int pin)
>  {
>  	struct rt2880_priv *p = pinctrl_dev_get_drvdata(pctrldev);
>  
> @@ -355,13 +356,13 @@ static int rt2880_pinmux_pins(struct rt2880_priv *p)
>  	}
>  
>  	/* the buffer that tells us which pins are gpio */
> -	p->gpio = devm_kcalloc(p->dev,p->max_pins, sizeof(uint8_t),
> +	p->gpio = devm_kcalloc(p->dev, p->max_pins, sizeof(uint8_t),
>  			       GFP_KERNEL);
>  	/* the pads needed to tell pinctrl about our pins */
>  	p->pads = devm_kcalloc(p->dev,
>  		p->max_pins, sizeof(struct pinctrl_pin_desc),
>  		GFP_KERNEL);
> -	if (!p->pads || !p->gpio ) {
> +	if (!p->pads || !p->gpio) {
>  		dev_err(p->dev, "Failed to allocate gpio data\n");
>  		return -ENOMEM;
>  	}
> -- 
> 2.7.4

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch did many different things all at once, making it difficult
  to review.  All Linux kernel patches need to only do one thing at a
  time.  If you need to do multiple things (such as clean up all coding
  style issues in a file/driver), do it in a sequence of patches, each
  one doing only one thing.  This will make it easier to review the
  patches to ensure that they are correct, and to help alleviate any
  merge issues that larger patches can cause.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
