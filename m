Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934005AbeE2MTt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 08:19:49 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33799 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933672AbeE2MTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 08:19:40 -0400
X-Google-Smtp-Source: ADUXVKLqTK6/SPC/PYmWFxgDjXMXyyO0WpHbuaP9JcRdf7y9T+hvJ7JgU0a7REcHfikFF6I5JfgNKQ==
Subject: Re: [PATCH v2 4/4] mmc: sdhci-msm: Add sdhci msm register write APIs
 which wait for pwr irq
To: Vijay Viswanath <vviswana@codeaurora.org>
Cc: adrian.hunter@intel.com, ulf.hansson@linaro.org, will.deacon@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        asutoshd@codeaurora.org, stummala@codeaurora.org,
        riteshh@codeaurora.org, subhashj@codeaurora.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <1506490483-46871-1-git-send-email-vviswana@codeaurora.org>
 <1506490483-46871-5-git-send-email-vviswana@codeaurora.org>
From: Georgi Djakov <georgi.djakov@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <74a4fe0e-7ae8-9f49-5614-1e01ae977475@linaro.org>
Date: Tue, 29 May 2018 15:19:34 +0300
MIME-Version: 1.0
In-Reply-To: <1506490483-46871-5-git-send-email-vviswana@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Vijay,

On 09/27/2017 08:34 AM, Vijay Viswanath wrote:
> Register writes which change voltage of IO lines or turn the IO bus
> on/off require controller to be ready before progressing further. When
> the controller is ready, it will generate a power irq which needs to be
> handled. The thread which initiated the register write should wait for
> power irq to complete. This will be done through the new sdhc msm write
> APIs which will check whether the particular write can trigger a power
> irq and wait for it with a timeout if it is expected.
> The SDHC core power control IRQ gets triggered when -
> * There is a state change in power control bit (bit 0)
>   of SDHCI_POWER_CONTROL register.
> * There is a state change in 1.8V enable bit (bit 3) of
>   SDHCI_HOST_CONTROL2 register.
> * Bit 1 of SDHCI_SOFTWARE_RESET is set.
> 
> Also add support APIs which are used by sdhc msm write APIs to check
> if power irq is expected to be generated and wait for the power irq
> to come and complete if the irq is expected.
> 
> This patch requires CONFIG_MMC_SDHCI_IO_ACCESSORS to be enabled.
> 
> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> Signed-off-by: Vijay Viswanath <vviswana@codeaurora.org>
> ---
>  drivers/mmc/host/sdhci-msm.c | 173 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 171 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c

[..]

> +/*
> + * sdhci_msm_check_power_status API should be called when registers writes
> + * which can toggle sdhci IO bus ON/OFF or change IO lines HIGH/LOW happens.
> + * To what state the register writes will change the IO lines should be passed
> + * as the argument req_type. This API will check whether the IO line's state
> + * is already the expected state and will wait for power irq only if
> + * power irq is expected to be trigerred based on the current IO line state
> + * and expected IO line state.
> + */
> +static void sdhci_msm_check_power_status(struct sdhci_host *host, u32 req_type)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
> +	bool done = false;
> +
> +	pr_debug("%s: %s: request %d curr_pwr_state %x curr_io_level %x\n",
> +			mmc_hostname(host->mmc), __func__, req_type,
> +			msm_host->curr_pwr_state, msm_host->curr_io_level);
> +
> +	/*
> +	 * The IRQ for request type IO High/LOW will be generated when -
> +	 * there is a state change in 1.8V enable bit (bit 3) of
> +	 * SDHCI_HOST_CONTROL2 register. The reset state of that bit is 0
> +	 * which indicates 3.3V IO voltage. So, when MMC core layer tries
> +	 * to set it to 3.3V before card detection happens, the
> +	 * IRQ doesn't get triggered as there is no state change in this bit.
> +	 * The driver already handles this case by changing the IO voltage
> +	 * level to high as part of controller power up sequence. Hence, check
> +	 * for host->pwr to handle a case where IO voltage high request is
> +	 * issued even before controller power up.
> +	 */
> +	if ((req_type & REQ_IO_HIGH) && !host->pwr) {
> +		pr_debug("%s: do not wait for power IRQ that never comes, req_type: %d\n",
> +				mmc_hostname(host->mmc), req_type);
> +		return;
> +	}
> +	if ((req_type & msm_host->curr_pwr_state) ||
> +			(req_type & msm_host->curr_io_level))
> +		done = true;
> +	/*
> +	 * This is needed here to handle cases where register writes will
> +	 * not change the current bus state or io level of the controller.
> +	 * In this case, no power irq will be triggerred and we should
> +	 * not wait.
> +	 */
> +	if (!done) {
> +		if (!wait_event_timeout(msm_host->pwr_irq_wait,
> +				msm_host->pwr_irq_flag,
> +				msecs_to_jiffies(MSM_PWR_IRQ_TIMEOUT_MS)))
> +			__WARN_printf("%s: pwr_irq for req: (%d) timed out\n",
> +					mmc_hostname(host->mmc), req_type);

I am seeing the above error message on a db820c device (apq8096). When i
unplug the SD card and then plug it back in, there is a 5 sec card
detection delay and a timeout. Here is a log:

[   50.253997] mmc0: card 59b4 removed
[   50.381874] mmc0: sdhci_msm_check_power_status: request 1
curr_pwr_state 2 curr_io_level 4 sdhci_host_ctrl2 b
[   50.382656] mmc0: sdhci_msm_check_power_status: request 1 done
[   50.392493] mmc0: sdhci_msm_check_power_status: request 4
curr_pwr_state 1 curr_io_level 4 sdhci_host_ctrl2 b
[   50.398258] mmc0: sdhci_msm_check_power_status: request 4 done
[   50.408728] mmc0: sdhci_msm_check_power_status: request 4
curr_pwr_state 1 curr_io_level 4 sdhci_host_ctrl2 8
[   50.413865] mmc0: sdhci_msm_check_power_status: request 4 done
[   54.966316] mmc0: sdhci_msm_check_power_status: request 2
curr_pwr_state 1 curr_io_level 4 sdhci_host_ctrl2 8  <-- card is plugged
[   54.967756] mmc0: sdhci_msm_check_power_status: request 2 done
[   54.976822] mmc0: sdhci_msm_check_power_status: request 4
curr_pwr_state 2 curr_io_level 8 sdhci_host_ctrl2 8
[   60.132253] sdhci_msm 74a4900.sdhci: mmc0: pwr_irq for req: (4) timed out
[   60.132782] mmc0: sdhci_msm_check_power_status: request 4 done
[   60.139888] mmc0: sdhci_msm_check_power_status: request 4
curr_pwr_state 2 curr_io_level 8 sdhci_host_ctrl2 8
[   65.252497] sdhci_msm 74a4900.sdhci: mmc0: pwr_irq for req: (4) timed out

The following patch seem to "fix" it.

-- >8 --
diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index b2d875afae5f..ca8ad4edcf80 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -1049,6 +1049,11 @@ static void sdhci_msm_check_power_status(struct
sdhci_host *host, u32 req_type)
                return;
        }

+       if (req_type & REQ_IO_LOW &&
+           msm_host->curr_pwr_state & REQ_BUS_ON &&
+           msm_host->curr_io_level & REQ_IO_HIGH &&
+           !host->pwr)
+               done = true;
        /*
         * The IRQ for request type IO High/LOW will be generated when -
         * there is a state change in 1.8V enable bit (bit 3) of
-- >8 --

Reverting this patch series or applying the above patch makes the issue
go away. According to the log, there is no change in the
sdhci_host_ctrl2 register. What do you think?

Thanks,
Georgi
