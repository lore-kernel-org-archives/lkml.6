Return-Path: <broonie@sirena.org.uk>
X-Google-Smtp-Source: AB8JxZqbLPAqZJopYHL15PHssLCvpucek1Nip0LNApXOTzdy05Z0QpAn9lnjq/zVtmzzJpCRDlyc
ARC-Seal: i=1; a=rsa-sha256; t=1526917667; cv=none;
        d=google.com; s=arc-20160816;
        b=N9DhriRzCiOZu6Y4kwQmFVTJ/rmKzRgCg8RzlBCekPJuIYN0a8U8pgZHXtL0LssogJ
         w5ojiXaTXhJgMvuulW9PonmeFt7Czmn7kQD2UjZD2plt51oI6kqe32B+yClD1DTLehXf
         l800HEBs2/Ovm2Rd9qCQpnKgmLp3BmoSk2hKHLwUwNImPury/HFhWGlw4M+1zFEhBKE4
         b9RnFEwBgG5tlxMaajT8wq9fcC/nozmTRDoNC5kg0D6DdY7zh6DsdZNY8n8AsYnITYSB
         g2N0ZhF8pmNLoNmn563gkO5DFdP/nKy5Uw0HIcRaOHutpJ1iJMcVcVfqF54C7OMLFXp/
         sgHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=date:message-id:in-reply-to:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=YmVQlyAUHiTORA3zYDl4Q8iJQ8/ZLqhallI6s8eC6Iw=;
        b=PoyHcDSG/lLqj3k2kEtMj/4ZIEPIde3HaIUveFDiH8vLIfLuJuxW4qkfpQ9OVGKb3d
         cM+Cmt/H14NyGZ7InZEbjx5WTf14mkTs8TcRiuQlCIjxFsgUubj9orBJ5Ba7amqHLdYO
         3GVu9SjAaJ9pU+1VyWv+9879ySAY4xEQyxljCAk3BRbp6RMzT0J/Rr2eaa3UwvjG0OpT
         ez6DMgYgPCiFaqBLGn3yDf1IA84Bz7h+JM7xfj2aPEogJyEyXiy72yjNqnkmdkRk/J8l
         bvV44oc/quBW9DpGwmeJoAW7QaQnkqTyDe+QdIylfgZAwaSVj8x/UiTJ6jFfMmzBT+vS
         aJfw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=Fa5BotqR;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=Fa5BotqR;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
From: Mark Brown <broonie@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, broonie@kernel.org, linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, mark.rutland@arm.com, devicetree@vger.kernel.org, rohkumar@qti.qualcomm.com, gregkh@linuxfoundation.org, plai@codeaurora.org, lgirdwood@gmail.com, tiwai@suse.com, david.brown@linaro.org, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, spatakok@qti.qualcomm.com, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: qdsp6: q6asm: Add support to memory map and unmap" to the asoc tree
In-Reply-To: <20180518125610.26200-8-srinivas.kandagatla@linaro.org>
Message-Id: <E1fKn2I-0007A6-0f@debutante>
Date: Mon, 21 May 2018 16:47:46 +0100
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601089219618380943?=
X-GMAIL-MSGID: =?utf-8?q?1601089219618380943?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The patch

   ASoC: qdsp6: q6asm: Add support to memory map and unmap

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From a2a5d30218fdf6ad869248ef46bf35b912dc1686 Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Fri, 18 May 2018 13:56:02 +0100
Subject: [PATCH] ASoC: qdsp6: q6asm: Add support to memory map and unmap

This patch adds support to memory map and unmap regions commands in
q6asm module.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
Reviewed-by: Banajit Goswami <bgoswami@codeaurora.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/qdsp6/q6asm.c | 347 +++++++++++++++++++++++++++++++++++
 sound/soc/qcom/qdsp6/q6asm.h |   5 +
 2 files changed, 352 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
index 585fcfbada6a..a20d243ed10a 100644
--- a/sound/soc/qcom/qdsp6/q6asm.c
+++ b/sound/soc/qcom/qdsp6/q6asm.c
@@ -19,10 +19,44 @@
 #include "q6dsp-errno.h"
 #include "q6dsp-common.h"
 
+#define ASM_CMD_SHARED_MEM_MAP_REGIONS		0x00010D92
+#define ASM_CMDRSP_SHARED_MEM_MAP_REGIONS	0x00010D93
+#define ASM_CMD_SHARED_MEM_UNMAP_REGIONS	0x00010D94
+
 #define ASM_SYNC_IO_MODE		0x0001
 #define ASM_ASYNC_IO_MODE		0x0002
 #define ASM_TUN_READ_IO_MODE		0x0004	/* tunnel read write mode */
 #define ASM_TUN_WRITE_IO_MODE		0x0008	/* tunnel read write mode */
+#define ASM_SHIFT_GAPLESS_MODE_FLAG	31
+#define ADSP_MEMORY_MAP_SHMEM8_4K_POOL	3
+
+struct avs_cmd_shared_mem_map_regions {
+	u16 mem_pool_id;
+	u16 num_regions;
+	u32 property_flag;
+} __packed;
+
+struct avs_shared_map_region_payload {
+	u32 shm_addr_lsw;
+	u32 shm_addr_msw;
+	u32 mem_size_bytes;
+} __packed;
+
+struct avs_cmd_shared_mem_unmap_regions {
+	u32 mem_map_handle;
+} __packed;
+
+struct audio_buffer {
+	phys_addr_t phys;
+	uint32_t size;		/* size of buffer */
+};
+
+struct audio_port_data {
+	struct audio_buffer *buf;
+	uint32_t num_periods;
+	uint32_t dsp_buf;
+	uint32_t mem_map_handle;
+};
 
 struct q6asm {
 	struct apr_device *adev;
@@ -44,6 +78,8 @@ struct audio_client {
 	struct mutex cmd_lock;
 	spinlock_t lock;
 	struct kref refcount;
+	/* idx:1 out port, 0: in port */
+	struct audio_port_data port[2];
 	wait_queue_head_t cmd_wait;
 	struct aprv2_ibasic_rsp_result_t result;
 	int perf_mode;
@@ -52,6 +88,275 @@ struct audio_client {
 	struct device *dev;
 };
 
+static inline void q6asm_add_hdr(struct audio_client *ac, struct apr_hdr *hdr,
+				 uint32_t pkt_size, bool cmd_flg,
+				 uint32_t stream_id)
+{
+	hdr->hdr_field = APR_SEQ_CMD_HDR_FIELD;
+	hdr->src_port = ((ac->session << 8) & 0xFF00) | (stream_id);
+	hdr->dest_port = ((ac->session << 8) & 0xFF00) | (stream_id);
+	hdr->pkt_size = pkt_size;
+	if (cmd_flg)
+		hdr->token = ac->session;
+}
+
+static int q6asm_apr_send_session_pkt(struct q6asm *a, struct audio_client *ac,
+				      struct apr_pkt *pkt, uint32_t rsp_opcode)
+{
+	struct apr_hdr *hdr = &pkt->hdr;
+	int rc;
+
+	mutex_lock(&ac->cmd_lock);
+	ac->result.opcode = 0;
+	ac->result.status = 0;
+	rc = apr_send_pkt(a->adev, pkt);
+	if (rc < 0)
+		goto err;
+
+	if (rsp_opcode)
+		rc = wait_event_timeout(a->mem_wait,
+					(ac->result.opcode == hdr->opcode) ||
+					(ac->result.opcode == rsp_opcode),
+					5 * HZ);
+	else
+		rc = wait_event_timeout(a->mem_wait,
+					(ac->result.opcode == hdr->opcode),
+					5 * HZ);
+
+	if (!rc) {
+		dev_err(a->dev, "CMD timeout\n");
+		rc = -ETIMEDOUT;
+	} else if (ac->result.status > 0) {
+		dev_err(a->dev, "DSP returned error[%x]\n",
+			ac->result.status);
+		rc = -EINVAL;
+	}
+
+err:
+	mutex_unlock(&ac->cmd_lock);
+	return rc;
+}
+
+static int __q6asm_memory_unmap(struct audio_client *ac,
+				phys_addr_t buf_add, int dir)
+{
+	struct avs_cmd_shared_mem_unmap_regions *mem_unmap;
+	struct q6asm *a = dev_get_drvdata(ac->dev->parent);
+	struct apr_pkt *pkt;
+	int rc, pkt_size;
+	void *p;
+
+	if (ac->port[dir].mem_map_handle == 0) {
+		dev_err(ac->dev, "invalid mem handle\n");
+		return -EINVAL;
+	}
+
+	pkt_size = APR_HDR_SIZE + sizeof(*mem_unmap);
+	p = kzalloc(pkt_size, GFP_KERNEL);
+	if (!p)
+		return -ENOMEM;
+
+	pkt = p;
+	mem_unmap = p + APR_HDR_SIZE;
+
+	pkt->hdr.hdr_field = APR_SEQ_CMD_HDR_FIELD;
+	pkt->hdr.src_port = 0;
+	pkt->hdr.dest_port = 0;
+	pkt->hdr.pkt_size = pkt_size;
+	pkt->hdr.token = ((ac->session << 8) | dir);
+
+	pkt->hdr.opcode = ASM_CMD_SHARED_MEM_UNMAP_REGIONS;
+	mem_unmap->mem_map_handle = ac->port[dir].mem_map_handle;
+
+	rc = q6asm_apr_send_session_pkt(a, ac, pkt, 0);
+	if (rc < 0) {
+		kfree(pkt);
+		return rc;
+	}
+
+	ac->port[dir].mem_map_handle = 0;
+
+	kfree(pkt);
+	return 0;
+}
+
+
+static void q6asm_audio_client_free_buf(struct audio_client *ac,
+					struct audio_port_data *port)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&ac->lock, flags);
+	port->num_periods = 0;
+	kfree(port->buf);
+	port->buf = NULL;
+	spin_unlock_irqrestore(&ac->lock, flags);
+}
+
+/**
+ * q6asm_unmap_memory_regions() - unmap memory regions in the dsp.
+ *
+ * @dir: direction of audio stream
+ * @ac: audio client instanace
+ *
+ * Return: Will be an negative value on failure or zero on success
+ */
+int q6asm_unmap_memory_regions(unsigned int dir, struct audio_client *ac)
+{
+	struct audio_port_data *port;
+	int cnt = 0;
+	int rc = 0;
+
+	port = &ac->port[dir];
+	if (!port->buf) {
+		rc = -EINVAL;
+		goto err;
+	}
+
+	cnt = port->num_periods - 1;
+	if (cnt >= 0) {
+		rc = __q6asm_memory_unmap(ac, port->buf[dir].phys, dir);
+		if (rc < 0) {
+			dev_err(ac->dev, "%s: Memory_unmap_regions failed %d\n",
+				__func__, rc);
+			goto err;
+		}
+	}
+
+	q6asm_audio_client_free_buf(ac, port);
+
+err:
+	return rc;
+}
+EXPORT_SYMBOL_GPL(q6asm_unmap_memory_regions);
+
+static int __q6asm_memory_map_regions(struct audio_client *ac, int dir,
+				      size_t period_sz, unsigned int periods,
+				      bool is_contiguous)
+{
+	struct avs_cmd_shared_mem_map_regions *cmd = NULL;
+	struct avs_shared_map_region_payload *mregions = NULL;
+	struct q6asm *a = dev_get_drvdata(ac->dev->parent);
+	struct audio_port_data *port = NULL;
+	struct audio_buffer *ab = NULL;
+	struct apr_pkt *pkt;
+	void *p;
+	unsigned long flags;
+	uint32_t num_regions, buf_sz;
+	int rc, i, pkt_size;
+
+	if (is_contiguous) {
+		num_regions = 1;
+		buf_sz = period_sz * periods;
+	} else {
+		buf_sz = period_sz;
+		num_regions = periods;
+	}
+
+	/* DSP expects size should be aligned to 4K */
+	buf_sz = ALIGN(buf_sz, 4096);
+
+	pkt_size = APR_HDR_SIZE + sizeof(*cmd) +
+		   (sizeof(*mregions) * num_regions);
+
+	p = kzalloc(pkt_size, GFP_KERNEL);
+	if (!p)
+		return -ENOMEM;
+
+	pkt = p;
+	cmd = p + APR_HDR_SIZE;
+	mregions = p + APR_HDR_SIZE +  sizeof(*cmd);
+
+	pkt->hdr.hdr_field = APR_SEQ_CMD_HDR_FIELD;
+	pkt->hdr.src_port = 0;
+	pkt->hdr.dest_port = 0;
+	pkt->hdr.pkt_size = pkt_size;
+	pkt->hdr.token = ((ac->session << 8) | dir);
+	pkt->hdr.opcode = ASM_CMD_SHARED_MEM_MAP_REGIONS;
+
+	cmd->mem_pool_id = ADSP_MEMORY_MAP_SHMEM8_4K_POOL;
+	cmd->num_regions = num_regions;
+	cmd->property_flag = 0x00;
+
+	spin_lock_irqsave(&ac->lock, flags);
+	port = &ac->port[dir];
+
+	for (i = 0; i < num_regions; i++) {
+		ab = &port->buf[i];
+		mregions->shm_addr_lsw = lower_32_bits(ab->phys);
+		mregions->shm_addr_msw = upper_32_bits(ab->phys);
+		mregions->mem_size_bytes = buf_sz;
+		++mregions;
+	}
+	spin_unlock_irqrestore(&ac->lock, flags);
+
+	rc = q6asm_apr_send_session_pkt(a, ac, pkt,
+					ASM_CMDRSP_SHARED_MEM_MAP_REGIONS);
+
+	kfree(pkt);
+
+	return rc;
+}
+
+/**
+ * q6asm_map_memory_regions() - map memory regions in the dsp.
+ *
+ * @dir: direction of audio stream
+ * @ac: audio client instanace
+ * @phys: physcial address that needs mapping.
+ * @period_sz: audio period size
+ * @periods: number of periods
+ *
+ * Return: Will be an negative value on failure or zero on success
+ */
+int q6asm_map_memory_regions(unsigned int dir, struct audio_client *ac,
+			     phys_addr_t phys,
+			     size_t period_sz, unsigned int periods)
+{
+	struct audio_buffer *buf;
+	unsigned long flags;
+	int cnt;
+	int rc;
+
+	spin_lock_irqsave(&ac->lock, flags);
+	if (ac->port[dir].buf) {
+		dev_err(ac->dev, "Buffer already allocated\n");
+		spin_unlock_irqrestore(&ac->lock, flags);
+		return 0;
+	}
+
+	buf = kzalloc(((sizeof(struct audio_buffer)) * periods), GFP_ATOMIC);
+	if (!buf) {
+		spin_unlock_irqrestore(&ac->lock, flags);
+		return -ENOMEM;
+	}
+
+
+	ac->port[dir].buf = buf;
+
+	buf[0].phys = phys;
+	buf[0].size = period_sz;
+
+	for (cnt = 1; cnt < periods; cnt++) {
+		if (period_sz > 0) {
+			buf[cnt].phys = buf[0].phys + (cnt * period_sz);
+			buf[cnt].size = period_sz;
+		}
+	}
+	ac->port[dir].num_periods = periods;
+
+	spin_unlock_irqrestore(&ac->lock, flags);
+
+	rc = __q6asm_memory_map_regions(ac, dir, period_sz, periods, 1);
+	if (rc < 0) {
+		dev_err(ac->dev, "Memory_map_regions failed\n");
+		q6asm_audio_client_free_buf(ac, &ac->port[dir]);
+	}
+
+	return rc;
+}
+EXPORT_SYMBOL_GPL(q6asm_map_memory_regions);
+
 static void q6asm_audio_client_release(struct kref *ref)
 {
 	struct audio_client *ac;
@@ -108,9 +413,13 @@ static int q6asm_srvc_callback(struct apr_device *adev,
 			       struct apr_resp_pkt *data)
 {
 	struct q6asm *q6asm = dev_get_drvdata(&adev->dev);
+	struct aprv2_ibasic_rsp_result_t *result;
+	struct audio_port_data *port;
 	struct audio_client *ac = NULL;
 	struct apr_hdr *hdr = &data->hdr;
+	struct q6asm *a;
 	uint32_t sid = 0;
+	uint32_t dir = 0;
 
 	sid = (hdr->token >> 8) & 0x0F;
 	ac = q6asm_get_audio_client(q6asm, sid);
@@ -119,9 +428,47 @@ static int q6asm_srvc_callback(struct apr_device *adev,
 		return 0;
 	}
 
+	a = dev_get_drvdata(ac->dev->parent);
+	dir = (hdr->token & 0x0F);
+	port = &ac->port[dir];
+	result = data->payload;
+
+	switch (hdr->opcode) {
+	case APR_BASIC_RSP_RESULT:
+		switch (result->opcode) {
+		case ASM_CMD_SHARED_MEM_MAP_REGIONS:
+		case ASM_CMD_SHARED_MEM_UNMAP_REGIONS:
+			ac->result = *result;
+			wake_up(&a->mem_wait);
+			break;
+		default:
+			dev_err(&adev->dev, "command[0x%x] not expecting rsp\n",
+				 result->opcode);
+			break;
+		}
+		goto done;
+	case ASM_CMDRSP_SHARED_MEM_MAP_REGIONS:
+		ac->result.status = 0;
+		ac->result.opcode = hdr->opcode;
+		port->mem_map_handle = result->opcode;
+		wake_up(&a->mem_wait);
+		break;
+	case ASM_CMD_SHARED_MEM_UNMAP_REGIONS:
+		ac->result.opcode = hdr->opcode;
+		ac->result.status = 0;
+		port->mem_map_handle = 0;
+		wake_up(&a->mem_wait);
+		break;
+	default:
+		dev_dbg(&adev->dev, "command[0x%x]success [0x%x]\n",
+			result->opcode, result->status);
+		break;
+	}
+
 	if (ac->cb)
 		ac->cb(hdr->opcode, hdr->token, data->payload, ac->priv);
 
+done:
 	kref_put(&ac->refcount, q6asm_audio_client_release);
 
 	return 0;
diff --git a/sound/soc/qcom/qdsp6/q6asm.h b/sound/soc/qcom/qdsp6/q6asm.h
index b7816e6384e7..8c317b7b63c3 100644
--- a/sound/soc/qcom/qdsp6/q6asm.h
+++ b/sound/soc/qcom/qdsp6/q6asm.h
@@ -12,4 +12,9 @@ struct audio_client *q6asm_audio_client_alloc(struct device *dev,
 					      int session_id, int perf_mode);
 void q6asm_audio_client_free(struct audio_client *ac);
 int q6asm_get_session_id(struct audio_client *ac);
+int q6asm_map_memory_regions(unsigned int dir,
+			     struct audio_client *ac,
+			     phys_addr_t phys,
+			     size_t bufsz, unsigned int bufcnt);
+int q6asm_unmap_memory_regions(unsigned int dir, struct audio_client *ac);
 #endif /* __Q6_ASM_H__ */
-- 
2.17.0
