Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC1BECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 11:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5B8021473
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 11:19:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5B8021473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbeJRTUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 15:20:17 -0400
Received: from mout.perfora.net ([74.208.4.196]:32945 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726173AbeJRTUQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 15:20:16 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MgMYS-1g1Ux913YM-00Nhhn; Thu, 18 Oct 2018 13:18:45 +0200
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MgMYS-1g1Ux913YM-00Nhhn; Thu, 18 Oct 2018 13:18:45 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     alsa-devel@alsa-project.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jiri Kosina <trivial@kernel.org>
Subject: [PATCH v1 2/3] ASoC: soc-core: fix trivial checkpatch issues
Date:   Thu, 18 Oct 2018 13:18:28 +0200
Message-Id: <20181018111829.27056-3-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181018111829.27056-1-marcel@ziswiler.com>
References: <20181018111829.27056-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:TH4NhWHHgpdnjFvv4tywb6cXOXUm16Axs/RXQPfa0rz2TNlgEib
 4DdxTT2VVf9ZeSC8++9JwZLD7qAribF5xiBZEvhuBSOnZkYIKdvtnWweUwEkd52ag19ie4t
 YZ/RQJ2lo2EdACdDLr0FPVmAlC+IKMXdvkqNTxIOyZVHcISuCk+y3RZrLyTvAif9zRgAuEv
 dYhW+BaNvmlwqDQA1MAkg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:22yScVG7dPM=:+jk/1Y3K44Bi67I6jayQml
 SCbHAfx5t1SHJHMLZEH9pUjHE75pgJ86E6o3F7TC3H6b+qOCAoEPsghS355KBtOTf5runGGlH
 0o6c9tk00P9a5dOTxz0IvOvBv3W0vAhziQ+m1+UexfkSl82RaqvdcWosW5GS47Jse7mUiDngF
 usXgbsB6fNcp/zOrt6f/xSkDZ3HATKOQZOScj6WXHK8tRMssJdbg2v8vVWJXy7KJX+xUGrTM7
 tAChavjm0ve25/TweyDLOlySWxfVeqJErlRKb8GX94VhrlHrNchaMBXjPd4EFtDttnHOEb+gT
 XZ/GLm12QilXMNc52HMeB5lT7NQw53d0JdgZmpTAvO1UUE9J7trWWpXprWp3GlJEtIas3IDCS
 ZSfcWjDnuaYifzNkixpP8lwiuH8W2bgMOMwsVj8Uf1l9yasr3DbAOnIl/pAbwRSKgCBmn+pg5
 P9NOp4NhhaYPEVNZQC+lbq5Io9oZiLj7aZusbJk8lLSeHdl4UFx2l/ag1waXX1h/frtMqkdEL
 28ymJOE5pUK163t9xPHTwc5qTLp6qLrtQrnsyLC5O5gCIGiu0MfVoAoiANFVz3ErJcVGweiT7
 I3kKztyuP7gQBiGIPAL0PNnGMSTB/TQR7obkKc5xZ+gLESCi4KGacFPRlEM8bAeihyJBzuG/Q
 DnLIx2/lHhCCS+J3NTa+mA2ocg6pYtQ05LAXhp1wbElpB3xi/sX51i8rKdD/rh+o/BcM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Fix a few trivial aka cosmetic only checkpatch issues like long lines,
wrong indentations, spurious blanks and newlines, missing newlines,
multi-line comments etc.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v1: None

 sound/soc/soc-core.c | 146 +++++++++++++++++++++++++++++++--------------------
 1 file changed, 88 insertions(+), 58 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 62e8e36062df..6ddcf12bc030 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -66,8 +66,9 @@ static int pmdown_time = 5000;
 module_param(pmdown_time, int, 0);
 MODULE_PARM_DESC(pmdown_time, "DAPM stream powerdown time (msecs)");
 
-/* If a DMI filed contain strings in this blacklist (e.g.
- * "Type2 - Board Manufacturer" or  "Type1 - TBD by OEM"), it will be taken
+/*
+ * If a DMI filed contain strings in this blacklist (e.g.
+ * "Type2 - Board Manufacturer" or "Type1 - TBD by OEM"), it will be taken
  * as invalid and dropped when setting the card long name from DMI info.
  */
 static const char * const dmi_blacklist[] = {
@@ -222,7 +223,7 @@ static void soc_init_card_debugfs(struct snd_soc_card *card)
 						    &card->pop_time);
 	if (!card->debugfs_pop_time)
 		dev_warn(card->dev,
-		       "ASoC: Failed to create pop time debugfs file\n");
+			 "ASoC: Failed to create pop time debugfs file\n");
 }
 
 static void soc_cleanup_card_debugfs(struct snd_soc_card *card)
@@ -426,7 +427,8 @@ EXPORT_SYMBOL_GPL(snd_soc_get_pcm_runtime);
 
 static void codec2codec_close_delayed_work(struct work_struct *work)
 {
-	/* Currently nothing to do for c2c links
+	/*
+	 * Currently nothing to do for c2c links
 	 * Since c2c links are internal nodes in the DAPM graph and
 	 * don't interface with the outside world or application layer
 	 * we don't have to do any special handling on close.
@@ -446,8 +448,9 @@ int snd_soc_suspend(struct device *dev)
 	if (!card->instantiated)
 		return 0;
 
-	/* Due to the resume being scheduled into a workqueue we could
-	* suspend before that's finished - wait for it to complete.
+	/*
+	 * Due to the resume being scheduled into a workqueue we could
+	 * suspend before that's finished - wait for it to complete.
 	 */
 	snd_power_wait(card->snd_card, SNDRV_CTL_POWER_D0);
 
@@ -514,10 +517,13 @@ int snd_soc_suspend(struct device *dev)
 
 	/* suspend all COMPONENTs */
 	for_each_card_components(card, component) {
-		struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
+		struct snd_soc_dapm_context *dapm =
+				snd_soc_component_get_dapm(component);
 
-		/* If there are paths active then the COMPONENT will be held with
-		 * bias _ON and should not be suspended. */
+		/*
+		 * If there are paths active then the COMPONENT will be held
+		 * with bias _ON and should not be suspended.
+		 */
 		if (!component->suspended) {
 			switch (snd_soc_dapm_get_bias_level(dapm)) {
 			case SND_SOC_BIAS_STANDBY:
@@ -571,18 +577,21 @@ int snd_soc_suspend(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(snd_soc_suspend);
 
-/* deferred resume work, so resume can complete before we finished
+/*
+ * deferred resume work, so resume can complete before we finished
  * setting our codec back up, which can be very slow on I2C
  */
 static void soc_resume_deferred(struct work_struct *work)
 {
 	struct snd_soc_card *card =
-			container_of(work, struct snd_soc_card, deferred_resume_work);
+			container_of(work, struct snd_soc_card,
+				     deferred_resume_work);
 	struct snd_soc_pcm_runtime *rtd;
 	struct snd_soc_component *component;
 	int i;
 
-	/* our power state is still SNDRV_CTL_POWER_D3hot from suspend time,
+	/*
+	 * our power state is still SNDRV_CTL_POWER_D3hot from suspend time,
 	 * so userspace apps are blocked from touching us
 	 */
 
@@ -699,6 +708,7 @@ int snd_soc_resume(struct device *dev)
 	 */
 	for_each_card_rtds(card, rtd) {
 		struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+
 		bus_control |= cpu_dai->driver->bus_control;
 	}
 	if (bus_control) {
@@ -777,7 +787,7 @@ struct snd_soc_dai *snd_soc_find_dai(
 
 	lockdep_assert_held(&client_mutex);
 
-	/* Find CPU DAI from registered DAIs*/
+	/* Find CPU DAI from registered DAIs */
 	for_each_component(component) {
 		if (!snd_soc_is_matching_component(dlc, component))
 			continue;
@@ -795,7 +805,6 @@ struct snd_soc_dai *snd_soc_find_dai(
 }
 EXPORT_SYMBOL_GPL(snd_soc_find_dai);
 
-
 /**
  * snd_soc_find_dai_link - Find a DAI link
  *
@@ -918,7 +927,7 @@ static int soc_bind_dai_link(struct snd_soc_card *card,
 
 _err_defer:
 	soc_free_pcm_runtime(rtd);
-	return  -EPROBE_DEFER;
+	return -EPROBE_DEFER;
 }
 
 static void soc_remove_component(struct snd_soc_component *component)
@@ -1074,7 +1083,7 @@ static int snd_soc_init_multicodec(struct snd_soc_card *card,
 }
 
 static int soc_init_dai_link(struct snd_soc_card *card,
-				   struct snd_soc_dai_link *link)
+			     struct snd_soc_dai_link *link)
 {
 	int i, ret;
 	struct snd_soc_dai_link_component *codec;
@@ -1148,7 +1157,8 @@ static int soc_init_dai_link(struct snd_soc_card *card,
 
 void snd_soc_disconnect_sync(struct device *dev)
 {
-	struct snd_soc_component *component = snd_soc_lookup_component(dev, NULL);
+	struct snd_soc_component *component =
+			snd_soc_lookup_component(dev, NULL);
 
 	if (!component || !component->card)
 		return;
@@ -1179,7 +1189,8 @@ int snd_soc_add_dai_link(struct snd_soc_card *card,
 	}
 
 	lockdep_assert_held(&client_mutex);
-	/* Notify the machine driver for extra initialization
+	/*
+	 * Notify the machine driver for extra initialization
 	 * on the link created by topology.
 	 */
 	if (dai_link->dobj.type && card->add_dai_link)
@@ -1214,7 +1225,8 @@ void snd_soc_remove_dai_link(struct snd_soc_card *card,
 	}
 
 	lockdep_assert_held(&client_mutex);
-	/* Notify the machine driver for extra destruction
+	/*
+	 * Notify the machine driver for extra destruction
 	 * on the link created by topology.
 	 */
 	if (dai_link->dobj.type && card->remove_dai_link)
@@ -1274,7 +1286,8 @@ static void soc_set_name_prefix(struct snd_soc_card *card,
 static int soc_probe_component(struct snd_soc_card *card,
 	struct snd_soc_component *component)
 {
-	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
+	struct snd_soc_dapm_context *dapm =
+			snd_soc_component_get_dapm(component);
 	struct snd_soc_dai *dai;
 	int ret;
 
@@ -1406,8 +1419,7 @@ static int soc_post_component_init(struct snd_soc_pcm_runtime *rtd,
 }
 
 static int soc_probe_link_components(struct snd_soc_card *card,
-			struct snd_soc_pcm_runtime *rtd,
-				     int order)
+				     struct snd_soc_pcm_runtime *rtd, int order)
 {
 	struct snd_soc_component *component;
 	struct snd_soc_rtdcom_list *rtdcom;
@@ -1434,6 +1446,7 @@ static int soc_probe_dai(struct snd_soc_dai *dai, int order)
 
 	if (dai->driver->probe) {
 		int ret = dai->driver->probe(dai);
+
 		if (ret < 0) {
 			dev_err(dai->dev, "ASoC: failed to probe DAI %s: %d\n",
 				dai->name, ret);
@@ -1541,7 +1554,7 @@ static int soc_probe_link_dais(struct snd_soc_card *card,
 	}
 
 	if (cpu_dai->driver->compress_new) {
-		/*create compress_device"*/
+		/* create compress_device" */
 		ret = cpu_dai->driver->compress_new(rtd, num);
 		if (ret < 0) {
 			dev_err(card->dev, "ASoC: can't create compress %s\n",
@@ -1555,7 +1568,7 @@ static int soc_probe_link_dais(struct snd_soc_card *card,
 			ret = soc_new_pcm(rtd, num);
 			if (ret < 0) {
 				dev_err(card->dev, "ASoC: can't create pcm %s :%d\n",
-				       dai_link->stream_name, ret);
+					dai_link->stream_name, ret);
 				return ret;
 			}
 			ret = soc_link_dai_pcm_new(&cpu_dai, 1, rtd);
@@ -1683,8 +1696,10 @@ int snd_soc_runtime_set_dai_fmt(struct snd_soc_pcm_runtime *rtd,
 		}
 	}
 
-	/* Flip the polarity for the "CPU" end of a CODEC<->CODEC link */
-	/* the component which has non_legacy_dai_naming is Codec */
+	/*
+	 * Flip the polarity for the "CPU" end of a CODEC<->CODEC link
+	 * the component which has non_legacy_dai_naming is Codec
+	 */
 	if (cpu_dai->component->driver->non_legacy_dai_naming) {
 		unsigned int inv_dai_fmt;
 
@@ -1718,9 +1733,9 @@ int snd_soc_runtime_set_dai_fmt(struct snd_soc_pcm_runtime *rtd,
 }
 EXPORT_SYMBOL_GPL(snd_soc_runtime_set_dai_fmt);
 
-
 #ifdef CONFIG_DMI
-/* Trim special characters, and replace '-' with '_' since '-' is used to
+/*
+ * Trim special characters, and replace '-' with '_' since '-' is used to
  * separate different DMI fields in the card long name. Only number and
  * alphabet characters and a few separator characters are kept.
  */
@@ -1739,7 +1754,8 @@ static void cleanup_dmi_name(char *name)
 	name[j] = '\0';
 }
 
-/* Check if a DMI field is valid, i.e. not containing any string
+/*
+ * Check if a DMI field is valid, i.e. not containing any string
  * in the black list.
  */
 static int is_dmi_valid(const char *field)
@@ -1802,7 +1818,6 @@ int snd_soc_set_dmi_name(struct snd_soc_card *card, const char *flavour)
 		return 0;
 	}
 
-
 	snprintf(card->dmi_longname, sizeof(card->snd_card->longname),
 			 "%s", vendor);
 	cleanup_dmi_name(card->dmi_longname);
@@ -1818,7 +1833,8 @@ int snd_soc_set_dmi_name(struct snd_soc_card *card, const char *flavour)
 		if (len < longname_buf_size)
 			cleanup_dmi_name(card->dmi_longname + len);
 
-		/* some vendors like Lenovo may only put a self-explanatory
+		/*
+		 * some vendors like Lenovo may only put a self-explanatory
 		 * name in the product version field
 		 */
 		product_version = dmi_get_system_info(DMI_PRODUCT_VERSION);
@@ -1914,7 +1930,8 @@ static void soc_check_tplg_fes(struct snd_soc_card *card)
 			dai_link->be_hw_params_fixup =
 				component->driver->be_hw_params_fixup;
 
-			/* most BE links don't set stream name, so set it to
+			/*
+			 * most BE links don't set stream name, so set it to
 			 * dai link name if it's NULL to help bind widgets.
 			 */
 			if (!dai_link->stream_name)
@@ -1924,7 +1941,7 @@ static void soc_check_tplg_fes(struct snd_soc_card *card)
 		/* Inform userspace we are using alternate topology */
 		if (component->driver->topology_name_prefix) {
 
-			/* topology shortname created ? */
+			/* topology shortname created? */
 			if (!card->topology_shortname_created) {
 				comp_drv = component->driver;
 
@@ -2029,7 +2046,8 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 	if (ret < 0)
 		goto probe_dai_err;
 
-	/* Find new DAI links added during probing components and bind them.
+	/*
+	 * Find new DAI links added during probing components and bind them.
 	 * Components with topology may bring new DAIs and DAI links.
 	 */
 	for_each_card_links(card, dai_link) {
@@ -2061,7 +2079,8 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 	snd_soc_dapm_connect_dai_link_widgets(card);
 
 	if (card->controls)
-		snd_soc_add_card_controls(card, card->controls, card->num_controls);
+		snd_soc_add_card_controls(card, card->controls,
+					  card->num_controls);
 
 	if (card->dapm_routes)
 		snd_soc_dapm_add_routes(&card->dapm, card->dapm_routes,
@@ -2207,8 +2226,10 @@ int snd_soc_poweroff(struct device *dev)
 	if (!card->instantiated)
 		return 0;
 
-	/* Flush out pmdown_time work - we actually do want to run it
-	 * now, we're shutting down so no imminent restart. */
+	/*
+	 * Flush out pmdown_time work - we actually do want to run it
+	 * now, we're shutting down so no imminent restart.
+	 */
 	for_each_card_rtds(card, rtd)
 		flush_delayed_work(&rtd->delayed_work);
 
@@ -2301,6 +2322,7 @@ static int snd_soc_add_controls(struct snd_card *card, struct device *dev,
 
 	for (i = 0; i < num_controls; i++) {
 		const struct snd_kcontrol_new *control = &controls[i];
+
 		err = snd_ctl_add(card, snd_soc_cnew(control, data,
 						     control->name, prefix));
 		if (err < 0) {
@@ -2418,8 +2440,9 @@ EXPORT_SYMBOL_GPL(snd_soc_dai_set_sysclk);
  *
  * Configures the CODEC master (MCLK) or system (SYSCLK) clocking.
  */
-int snd_soc_component_set_sysclk(struct snd_soc_component *component, int clk_id,
-			     int source, unsigned int freq, int dir)
+int snd_soc_component_set_sysclk(struct snd_soc_component *component,
+				 int clk_id, int source, unsigned int freq,
+				 int dir)
 {
 	if (component->driver->set_sysclk)
 		return component->driver->set_sysclk(component, clk_id, source,
@@ -2487,7 +2510,7 @@ int snd_soc_component_set_pll(struct snd_soc_component *component, int pll_id,
 {
 	if (component->driver->set_pll)
 		return component->driver->set_pll(component, pll_id, source,
-					      freq_in, freq_out);
+						  freq_in, freq_out);
 
 	return -EINVAL;
 }
@@ -2533,8 +2556,8 @@ EXPORT_SYMBOL_GPL(snd_soc_dai_set_fmt);
  * Generates the TDM tx and rx slot default masks for DAI.
  */
 static int snd_soc_xlate_tdm_slot_mask(unsigned int slots,
-					  unsigned int *tx_mask,
-					  unsigned int *rx_mask)
+				       unsigned int *tx_mask,
+				       unsigned int *rx_mask)
 {
 	if (*tx_mask || *rx_mask)
 		return 0;
@@ -2684,7 +2707,7 @@ static int snd_soc_bind_card(struct snd_soc_card *card)
 		return ret;
 
 	/* deactivate pins to sleep state */
-	for_each_card_rtds(card, rtd)  {
+	for_each_card_rtds(card, rtd) {
 		struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 		struct snd_soc_dai *codec_dai;
 		int j;
@@ -2799,7 +2822,7 @@ static char *fmt_single_name(struct device *dev, int *id)
 		}
 
 	} else {
-		/* I2C component devices are named "bus-addr"  */
+		/* I2C component devices are named "bus-addr" */
 		if (sscanf(name, "%x-%x", &id1, &id2) == 2) {
 			char tmp[NAME_SIZE];
 
@@ -2807,7 +2830,8 @@ static char *fmt_single_name(struct device *dev, int *id)
 			*id = ((id1 & 0xffff) << 16) + id2;
 
 			/* sanitize component name for DAI link creation */
-			snprintf(tmp, NAME_SIZE, "%s.%s", dev->driver->name, name);
+			snprintf(tmp, NAME_SIZE, "%s.%s", dev->driver->name,
+				 name);
 			strlcpy(name, tmp, NAME_SIZE);
 		} else
 			*id = 0;
@@ -2874,7 +2898,7 @@ static struct snd_soc_dai *soc_add_dai(struct snd_soc_component *component,
 	 * component-less anymore.
 	 */
 	if (legacy_dai_naming &&
-	   (dai_drv->id == 0 || dai_drv->name == NULL)) {
+	    (dai_drv->id == 0 || dai_drv->name == NULL)) {
 		dai->name = fmt_single_name(dev, &dai->id);
 	} else {
 		dai->name = fmt_multiple_name(dev, dai_drv);
@@ -2910,7 +2934,8 @@ static struct snd_soc_dai *soc_add_dai(struct snd_soc_component *component,
  * @count: Number of DAIs
  */
 static int snd_soc_register_dais(struct snd_soc_component *component,
-				 struct snd_soc_dai_driver *dai_drv, size_t count)
+				 struct snd_soc_dai_driver *dai_drv,
+				 size_t count)
 {
 	struct device *dev = component->dev;
 	struct snd_soc_dai *dai;
@@ -2921,8 +2946,8 @@ static int snd_soc_register_dais(struct snd_soc_component *component,
 
 	for (i = 0; i < count; i++) {
 
-		dai = soc_add_dai(component, dai_drv + i,
-				  count == 1 && !component->driver->non_legacy_dai_naming);
+		dai = soc_add_dai(component, dai_drv + i, count == 1 &&
+				  !component->driver->non_legacy_dai_naming);
 		if (dai == NULL) {
 			ret = -ENOMEM;
 			goto err;
@@ -2966,7 +2991,8 @@ int snd_soc_register_dai(struct snd_soc_component *component,
 	if (!dai)
 		return -ENOMEM;
 
-	/* Create the DAI widgets here. After adding DAIs, topology may
+	/*
+	 * Create the DAI widgets here. After adding DAIs, topology may
 	 * also add routes that need these widgets as source or sink.
 	 */
 	ret = snd_soc_dapm_new_dai_widgets(dapm, dai);
@@ -3048,7 +3074,8 @@ static void snd_soc_component_setup_regmap(struct snd_soc_component *component)
 #ifdef CONFIG_REGMAP
 
 /**
- * snd_soc_component_init_regmap() - Initialize regmap instance for the component
+ * snd_soc_component_init_regmap() - Initialize regmap instance for the
+ *                                   component
  * @component: The component for which to initialize the regmap instance
  * @regmap: The regmap instance that should be used by the component
  *
@@ -3066,7 +3093,8 @@ void snd_soc_component_init_regmap(struct snd_soc_component *component,
 EXPORT_SYMBOL_GPL(snd_soc_component_init_regmap);
 
 /**
- * snd_soc_component_exit_regmap() - De-initialize regmap instance for the component
+ * snd_soc_component_exit_regmap() - De-initialize regmap instance for the
+ *                                   component
  * @component: The component for which to de-initialize the regmap instance
  *
  * Calls regmap_exit() on the regmap instance associated to the component and
@@ -3090,7 +3118,8 @@ static void snd_soc_component_add(struct snd_soc_component *component)
 
 	if (!component->driver->write && !component->driver->read) {
 		if (!component->regmap)
-			component->regmap = dev_get_regmap(component->dev, NULL);
+			component->regmap = dev_get_regmap(component->dev,
+							   NULL);
 		if (component->regmap)
 			snd_soc_component_setup_regmap(component);
 	}
@@ -3235,23 +3264,24 @@ static int __snd_soc_unregister_component(struct device *dev)
 		if (dev != component->dev)
 			continue;
 
-		snd_soc_tplg_component_remove(component, SND_SOC_TPLG_INDEX_ALL);
+		snd_soc_tplg_component_remove(component,
+					      SND_SOC_TPLG_INDEX_ALL);
 		snd_soc_component_del_unlocked(component);
 		found = 1;
 		break;
 	}
 	mutex_unlock(&client_mutex);
 
-	if (found) {
+	if (found)
 		snd_soc_component_cleanup(component);
-	}
 
 	return found;
 }
 
 void snd_soc_unregister_component(struct device *dev)
 {
-	while (__snd_soc_unregister_component(dev));
+	while (__snd_soc_unregister_component(dev))
+		;
 }
 EXPORT_SYMBOL_GPL(snd_soc_unregister_component);
 
@@ -3832,7 +3862,7 @@ int snd_soc_of_get_dai_link_codecs(struct device *dev,
 	for_each_link_codecs(dai_link, index, component) {
 		ret = of_parse_phandle_with_args(of_node, name,
 						 "#sound-dai-cells",
-						  index, &args);
+						 index, &args);
 		if (ret)
 			goto err;
 		component->of_node = args.np;
-- 
2.14.4

