Return-Path: <Alexey.Brodkin@synopsys.com>
X-Google-Smtp-Source: AIpwx4+RmJQSpLAwrP1NGbd5CpGNEmHXNp+I/uCJ3lfBK8sMjXzrCLJs8Nm5G7dgN9tE5g+IIOE3
ARC-Seal: i=1; a=rsa-sha256; t=1524043526; cv=none;
        d=google.com; s=arc-20160816;
        b=pC3hyj0G0T7ab/HMGUXW09RvYGpE6jkikR4BLAg0zPJ8QRwVUKYY/DjD6gUu0oVWb9
         MjBCbntwCXejw6mh4tXet3+2Fp76RxFyA3NwkzMNPiP3xAULrMNwmtJYroXLC3yUNUn2
         puwSmfSvuP04+99HCBUK18D6eycEftMBY5yON6qhgddQ68Q5SWeOUdnu94nYEkI9K0ye
         QwF6z5xcPhgNFBUXXRK74mUdrI1kJKG0wvU82NyvgxBZxDVP0qm6SAOlX0Ut3pRa8Cs+
         3xXNPkwfPiwaZ85fHLfiiNKfgcycjCd86oEeucfH+iic8CmUNe+IttaZ3F/nZho17YZ8
         XR6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:arc-authentication-results;
        bh=ASHCz9MkagiwMLU9OulX1h3C03guBMD0dL1K46xBKy4=;
        b=YXj1wDqNxXoUidc6RM9YNQBG9SV7dH3y0cwk6sYjqWB6+dBqum9XybXwsX4ft24rh/
         iuh/3KNCUmzqnGyJK8689yqz5zPJzgdKir0TeZm5mkEkwau/Tq+rlqKWV2abm/P8yJzq
         T0cNPeMckRu8ipOh7NBuj3w7zCrsDc5yuBZ8FYpBnBhrsxjTbXNWPLhG/2TvLLqTK0Tg
         VxmOdOnPhHFCbyNE7GB5TuUQEHluIjzR8UM6EGwZKjFSlrgLG5e4mtWGogQhDNhLdQFq
         XSisjxA6JqH3ggnnY5htVIFQcOmO6mX2IA124z75pE+M/hhh++pZ5JMo8DTTUmWvuAcr
         7c9w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of alexey.brodkin@synopsys.com designates 198.182.47.9 as permitted sender) smtp.mailfrom=Alexey.Brodkin@synopsys.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=synopsys.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of alexey.brodkin@synopsys.com designates 198.182.47.9 as permitted sender) smtp.mailfrom=Alexey.Brodkin@synopsys.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=synopsys.com
From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
To: dri-devel@lists.freedesktop.org
Cc: Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
	Borislav Petkov <bp@suse.de>, "Tobin C . Harding" <me@tobin.cc>,
	Alex Deucher <alexander.deucher@amd.com>,
	Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Benjamin Gaignard <benjamin.gaignard@linaro.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Christian Gmeiner <christian.gmeiner@gmail.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Cihangir Akturk <cakturk@gmail.com>, CK Hu <ck.hu@mediatek.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Airlie <airlied@redhat.com>, David Airlie <airlied@linux.ie>,
	"David (ChunMing) Zhou" <David1.Zhou@amd.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Harry Wentland <harry.wentland@amd.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Ingo Molnar <mingo@kernel.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	"Jerry (Fangzhi) Zuo" <Jerry.Zuo@amd.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	"Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Maxime Ripard <maxime.ripard@bootlin.com>,
	=?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@amd.com>,
	Oded Gabbay <oded.gabbay@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Clark <robdclark@gmail.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Roger He <Hongbo.He@amd.com>,
	Roman Li <Roman.Li@amd.com>, Russell King <linux@armlinux.org.uk>,
	Samuel Li <Samuel.Li@amd.com>, Sandy Huang <hjc@rock-chips.com>,
	Sean Paul <seanpaul@chromium.org>, Shirish S <shirish.s@amd.com>,
	Sinclair Yeh <syeh@vmware.com>,
	Thomas Hellstrom <thellstrom@vmware.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Tony Cheng <Tony.Cheng@amd.com>,
	Vincent Abriou <vincent.abriou@st.com>,
	VMware Graphics <linux-graphics-maintainer@vmware.com>,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-rockchip@lists.infradead.org, etnaviv@lists.freedesktop.org,
	freedreno@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	virtualization@lists.linux-foundation.org
Subject: [PATCH] drm: Print unadorned pointers
Date: Wed, 18 Apr 2018 12:24:50 +0300
Message-Id: <20180418092450.13798-1-abrodkin@synopsys.com>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598075464656416084?=
X-GMAIL-MSGID: =?utf-8?q?1598075464656416084?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

After commit ad67b74 ("printk: hash addresses printed with %p")
pointers are being hashed when printed. However, this makes
debug output completely useless. Switch to %px in order to see the
unadorned kernel pointers.

This was done with the following one-liner:
 find drivers/gpu/drm -type f -name "*.c" -exec sed -r -i '/DRM_DEBUG|KERN_DEBUG|pr_debug/ s/%p\b/%px/g' {} +

Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Tobin C. Harding <me@tobin.cc>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: Cihangir Akturk <cakturk@gmail.com>
Cc: CK Hu <ck.hu@mediatek.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Dave Airlie <airlied@redhat.com>
Cc: David Airlie <airlied@linux.ie>
Cc: "David (ChunMing) Zhou" <David1.Zhou@amd.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Gustavo Padovan <gustavo@padovan.org>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: "Heiko Stübner" <heiko@sntech.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: "Jerry (Fangzhi) Zuo" <Jerry.Zuo@amd.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: "Leo (Sunpeng) Li" <sunpeng.li@amd.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: "Michel Dänzer" <michel.daenzer@amd.com>
Cc: Oded Gabbay <oded.gabbay@gmail.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Rob Clark <robdclark@gmail.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Roger He <Hongbo.He@amd.com>
Cc: Roman Li <Roman.Li@amd.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Samuel Li <Samuel.Li@amd.com>
Cc: Sandy Huang <hjc@rock-chips.com>
Cc: Sean Paul <seanpaul@chromium.org>
Cc: Shirish S <shirish.s@amd.com>
Cc: Sinclair Yeh <syeh@vmware.com>
Cc: Thomas Hellstrom <thellstrom@vmware.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Tony Cheng <Tony.Cheng@amd.com>
Cc: Vincent Abriou <vincent.abriou@st.com>
Cc: VMware Graphics <linux-graphics-maintainer@vmware.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-mediatek@lists.infradead.org
Cc: linux-rockchip@lists.infradead.org
Cc: etnaviv@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org
Cc: virtualization@lists.linux-foundation.org
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   | 14 +++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c        |  4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           |  4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c            |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c            | 10 ++---
 drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c          |  4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_events.c            |  4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c      |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c           |  4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c             | 18 ++++-----
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 14 +++----
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |  2 +-
 drivers/gpu/drm/armada/armada_gem.c                | 12 +++---
 drivers/gpu/drm/drm_atomic.c                       | 44 +++++++++++-----------
 drivers/gpu/drm/drm_bufs.c                         |  8 ++--
 drivers/gpu/drm/drm_dp_mst_topology.c              |  4 +-
 drivers/gpu/drm/drm_lease.c                        |  6 +--
 drivers/gpu/drm/drm_lock.c                         |  2 +-
 drivers/gpu/drm/drm_scatter.c                      |  4 +-
 drivers/gpu/drm/etnaviv/etnaviv_drv.c              |  6 +--
 drivers/gpu/drm/i810/i810_dma.c                    |  2 +-
 drivers/gpu/drm/i915/i915_perf.c                   |  2 +-
 drivers/gpu/drm/i915/intel_display.c               |  2 +-
 drivers/gpu/drm/i915/intel_guc_ct.c                |  4 +-
 drivers/gpu/drm/i915/intel_guc_submission.c        |  2 +-
 drivers/gpu/drm/i915/intel_uc_fw.c                 |  2 +-
 drivers/gpu/drm/mediatek/mtk_drm_gem.c             |  2 +-
 drivers/gpu/drm/mga/mga_warp.c                     |  2 +-
 drivers/gpu/drm/msm/msm_drv.c                      |  4 +-
 drivers/gpu/drm/qxl/qxl_cmd.c                      |  4 +-
 drivers/gpu/drm/qxl/qxl_fb.c                       |  2 +-
 drivers/gpu/drm/qxl/qxl_ttm.c                      |  2 +-
 drivers/gpu/drm/radeon/radeon_display.c            |  2 +-
 drivers/gpu/drm/radeon/radeon_dp_mst.c             | 12 +++---
 drivers/gpu/drm/radeon/radeon_object.c             |  2 +-
 drivers/gpu/drm/rockchip/rockchip_drm_fbdev.c      |  2 +-
 drivers/gpu/drm/savage/savage_bci.c                |  2 +-
 drivers/gpu/drm/sti/sti_gdp.c                      |  4 +-
 drivers/gpu/drm/sti/sti_mixer.c                    |  2 +-
 drivers/gpu/drm/sun4i/sun4i_crtc.c                 |  4 +-
 drivers/gpu/drm/ttm/ttm_page_alloc.c               |  2 +-
 drivers/gpu/drm/udl/udl_fb.c                       |  2 +-
 drivers/gpu/drm/via/via_dma.c                      |  4 +-
 drivers/gpu/drm/via/via_irq.c                      |  2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c            |  2 +-
 45 files changed, 120 insertions(+), 120 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 1d6e1479da38..32e85fe83152 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -438,7 +438,7 @@ static int add_bo_to_vm(struct amdgpu_device *adev, struct kgd_mem *mem,
 	if (!bo_va_entry)
 		return -ENOMEM;
 
-	pr_debug("\t add VA 0x%llx - 0x%llx to vm %p\n", va,
+	pr_debug("\t add VA 0x%llx - 0x%llx to vm %px\n", va,
 			va + bo_size, vm);
 
 	/* Add BO to VM internal data structures*/
@@ -497,7 +497,7 @@ static int add_bo_to_vm(struct amdgpu_device *adev, struct kgd_mem *mem,
 static void remove_bo_from_vm(struct amdgpu_device *adev,
 		struct kfd_bo_va_list *entry, unsigned long size)
 {
-	pr_debug("\t remove VA 0x%llx - 0x%llx in entry %p\n",
+	pr_debug("\t remove VA 0x%llx - 0x%llx in entry %px\n",
 			entry->va,
 			entry->va + size, entry);
 	amdgpu_vm_bo_rmv(adev, entry->bo_va);
@@ -982,7 +982,7 @@ void amdgpu_amdkfd_gpuvm_destroy_process_vm(struct kgd_dev *kgd, void *vm)
 	if (WARN_ON(!kgd || !vm))
 		return;
 
-	pr_debug("Destroying process vm %p\n", vm);
+	pr_debug("Destroying process vm %px\n", vm);
 
 	/* Release the VM context */
 	amdgpu_vm_fini(adev, avm);
@@ -1191,7 +1191,7 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
 	domain = mem->domain;
 	bo_size = bo->tbo.mem.size;
 
-	pr_debug("Map VA 0x%llx - 0x%llx to vm %p domain %s\n",
+	pr_debug("Map VA 0x%llx - 0x%llx to vm %px domain %s\n",
 			mem->va,
 			mem->va + bo_size * (1 + mem->aql_queue),
 			vm, domain_string(domain));
@@ -1231,7 +1231,7 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
 
 	list_for_each_entry(entry, &mem->bo_va_list, bo_list) {
 		if (entry->bo_va->base.vm == vm && !entry->is_mapped) {
-			pr_debug("\t map VA 0x%llx - 0x%llx in entry %p\n",
+			pr_debug("\t map VA 0x%llx - 0x%llx in entry %px\n",
 					entry->va, entry->va + bo_size,
 					entry);
 
@@ -1302,14 +1302,14 @@ int amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
 	if (unlikely(ret))
 		goto unreserve_out;
 
-	pr_debug("Unmap VA 0x%llx - 0x%llx from vm %p\n",
+	pr_debug("Unmap VA 0x%llx - 0x%llx from vm %px\n",
 		mem->va,
 		mem->va + bo_size * (1 + mem->aql_queue),
 		vm);
 
 	list_for_each_entry(entry, &mem->bo_va_list, bo_list) {
 		if (entry->bo_va->base.vm == vm && entry->is_mapped) {
-			pr_debug("\t unmap VA 0x%llx - 0x%llx from entry %p\n",
+			pr_debug("\t unmap VA 0x%llx - 0x%llx from entry %px\n",
 					entry->va,
 					entry->va + bo_size,
 					entry);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 93f700ab1bfb..44a19d7cc941 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -112,7 +112,7 @@ static void amdgpu_display_flip_work_func(struct work_struct *__work)
 	spin_unlock_irqrestore(&crtc->dev->event_lock, flags);
 
 
-	DRM_DEBUG_DRIVER("crtc:%d[%p], pflip_stat:AMDGPU_FLIP_SUBMITTED, work: %p,\n",
+	DRM_DEBUG_DRIVER("crtc:%d[%px], pflip_stat:AMDGPU_FLIP_SUBMITTED, work: %px,\n",
 					 amdgpu_crtc->crtc_id, amdgpu_crtc, work);
 
 }
@@ -226,7 +226,7 @@ int amdgpu_display_crtc_page_flip_target(struct drm_crtc *crtc,
 	amdgpu_crtc->pflip_works = work;
 
 
-	DRM_DEBUG_DRIVER("crtc:%d[%p], pflip_stat:AMDGPU_FLIP_PENDING, work: %p,\n",
+	DRM_DEBUG_DRIVER("crtc:%d[%px], pflip_stat:AMDGPU_FLIP_PENDING, work: %px,\n",
 					 amdgpu_crtc->crtc_id, amdgpu_crtc, work);
 	/* update crtc fb */
 	crtc->primary->fb = fb;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index cd679cf1fd30..fc91de6a7f02 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -233,7 +233,7 @@ static int set_queue_properties_from_user(struct queue_properties *q_properties,
 	pr_debug("Queue Size: 0x%llX, %u\n",
 			q_properties->queue_size, args->ring_size);
 
-	pr_debug("Queue r/w Pointers: %p, %p\n",
+	pr_debug("Queue r/w Pointers: %px, %px\n",
 			q_properties->read_ptr,
 			q_properties->write_ptr);
 
@@ -725,7 +725,7 @@ static int kfd_ioctl_dbg_wave_control(struct file *filep,
 
 	mutex_lock(kfd_get_dbgmgr_mutex());
 
-	pr_debug("Calling dbg manager process %p, operand %u, mode %u, trapId %u, message %u\n",
+	pr_debug("Calling dbg manager process %px, operand %u, mode %u, trapId %u, message %u\n",
 			wac_info.process, wac_info.operand,
 			wac_info.mode, wac_info.trapId,
 			wac_info.dbgWave_msg.DbgWaveMsg.WaveMsgInfoGen2.Value);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c b/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c
index afb26f205d29..c3350d0270b2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_dbgdev.c
@@ -401,7 +401,7 @@ static int dbgdev_address_watch_diq(struct kfd_dbgdev *dbgdev,
 		pr_debug("\t\t%30s\n", "* * * * * * * * * * * * * * * * * *");
 		pr_debug("\t\t%20s %08x\n", "register index :", i);
 		pr_debug("\t\t%20s %08x\n", "vmid is :", vmid);
-		pr_debug("\t\t%20s %p\n", "Add ptr is :",
+		pr_debug("\t\t%20s %px\n", "Add ptr is :",
 				adw_info->watch_address);
 		pr_debug("\t\t%20s %08llx\n", "Add     is :",
 				adw_info->watch_address[i]);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 3346699960dd..57c26155e42e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -612,7 +612,7 @@ static int kfd_gtt_sa_init(struct kfd_dev *kfd, unsigned int buf_size,
 	if (!kfd->gtt_sa_bitmap)
 		return -ENOMEM;
 
-	pr_debug("gtt_sa_num_of_chunks = %d, gtt_sa_bitmap = %p\n",
+	pr_debug("gtt_sa_num_of_chunks = %d, gtt_sa_bitmap = %px\n",
 			kfd->gtt_sa_num_of_chunks, kfd->gtt_sa_bitmap);
 
 	mutex_init(&kfd->gtt_sa_lock);
@@ -656,7 +656,7 @@ int kfd_gtt_sa_allocate(struct kfd_dev *kfd, unsigned int size,
 	if ((*mem_obj) == NULL)
 		return -ENOMEM;
 
-	pr_debug("Allocated mem_obj = %p for size = %d\n", *mem_obj, size);
+	pr_debug("Allocated mem_obj = %px for size = %d\n", *mem_obj, size);
 
 	start_search = 0;
 
@@ -686,7 +686,7 @@ int kfd_gtt_sa_allocate(struct kfd_dev *kfd, unsigned int size,
 					found,
 					kfd->gtt_sa_chunk_size);
 
-	pr_debug("gpu_addr = %p, cpu_addr = %p\n",
+	pr_debug("gpu_addr = %px, cpu_addr = %px\n",
 			(uint64_t *) (*mem_obj)->gpu_addr, (*mem_obj)->cpu_ptr);
 
 	/* If we need only one chunk, mark it as allocated and get out */
@@ -740,7 +740,7 @@ int kfd_gtt_sa_allocate(struct kfd_dev *kfd, unsigned int size,
 	return 0;
 
 kfd_gtt_no_free_chunk:
-	pr_debug("Allocation failed with mem_obj = %p\n", mem_obj);
+	pr_debug("Allocation failed with mem_obj = %px\n", mem_obj);
 	mutex_unlock(&kfd->gtt_sa_lock);
 	kfree(mem_obj);
 	return -ENOMEM;
@@ -754,7 +754,7 @@ int kfd_gtt_sa_free(struct kfd_dev *kfd, struct kfd_mem_obj *mem_obj)
 	if (!mem_obj)
 		return 0;
 
-	pr_debug("Free mem_obj = %p, range_start = %d, range_end = %d\n",
+	pr_debug("Free mem_obj = %px, range_start = %d, range_end = %d\n",
 			mem_obj, mem_obj->range_start, mem_obj->range_end);
 
 	mutex_lock(&kfd->gtt_sa_lock);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
index ebb4da14e3df..7b5ad0c577c8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
@@ -116,7 +116,7 @@ int kfd_doorbell_init(struct kfd_dev *kfd)
 	pr_debug("doorbell aperture size  == 0x%08lX\n",
 			kfd->shared_resources.doorbell_aperture_size);
 
-	pr_debug("doorbell kernel address == %p\n", kfd->doorbell_kernel_ptr);
+	pr_debug("doorbell kernel address == %px\n", kfd->doorbell_kernel_ptr);
 
 	return 0;
 }
@@ -214,7 +214,7 @@ inline void write_kernel_doorbell(u32 __iomem *db, u32 value)
 {
 	if (db) {
 		writel(value, db);
-		pr_debug("Writing %d to doorbell address %p\n", value, db);
+		pr_debug("Writing %d to doorbell address %px\n", value, db);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index 4890a90f1e44..1b03308faa0e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -81,7 +81,7 @@ static struct kfd_signal_page *allocate_signal_page(struct kfd_process *p)
 
 	page->kernel_address = backing_store;
 	page->need_to_free_pages = true;
-	pr_debug("Allocated new event signal page at %p, for process %p\n",
+	pr_debug("Allocated new event signal page at %px, for process %px\n",
 			page, p);
 
 	return page;
@@ -202,7 +202,7 @@ static int create_signal_event(struct file *devkfd,
 	p->signal_event_count++;
 
 	ev->user_signal_address = &p->signal_page->user_address[ev->event_id];
-	pr_debug("Signal event number %zu created with id %d, address %p\n",
+	pr_debug("Signal event number %zu created with id %d, address %px\n",
 			p->signal_event_count, ev->event_id,
 			ev->user_signal_address);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
index 69f496485331..b39b5b813dab 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
@@ -222,7 +222,7 @@ static int acquire_packet_buffer(struct kernel_queue *kq,
 
 	pr_debug("rptr: %d\n", rptr);
 	pr_debug("wptr: %d\n", wptr);
-	pr_debug("queue_address 0x%p\n", queue_address);
+	pr_debug("queue_address 0x%px\n", queue_address);
 
 	available_size = (rptr + queue_size_dwords - 1 - wptr) %
 							queue_size_dwords;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 1711ad0642f7..c5c1b2158910 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -468,7 +468,7 @@ static int kfd_process_init_cwsr_apu(struct kfd_process *p, struct file *filep)
 		memcpy(qpd->cwsr_kaddr, dev->cwsr_isa, dev->cwsr_isa_size);
 
 		qpd->tma_addr = qpd->tba_addr + KFD_CWSR_TMA_OFFSET;
-		pr_debug("set tba :0x%llx, tma:0x%llx, cwsr_kaddr:%p for pqm.\n",
+		pr_debug("set tba :0x%llx, tma:0x%llx, cwsr_kaddr:%px for pqm.\n",
 			qpd->tba_addr, qpd->tma_addr, qpd->cwsr_kaddr);
 	}
 
@@ -499,7 +499,7 @@ static int kfd_process_device_init_cwsr_dgpu(struct kfd_process_device *pdd)
 	memcpy(qpd->cwsr_kaddr, dev->cwsr_isa, dev->cwsr_isa_size);
 
 	qpd->tma_addr = qpd->tba_addr + KFD_CWSR_TMA_OFFSET;
-	pr_debug("set tba :0x%llx, tma:0x%llx, cwsr_kaddr:%p for pqm.\n",
+	pr_debug("set tba :0x%llx, tma:0x%llx, cwsr_kaddr:%px for pqm.\n",
 		 qpd->tba_addr, qpd->tma_addr, qpd->cwsr_kaddr);
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
index a5315d4f1c95..56d3e05b53ba 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
@@ -36,9 +36,9 @@ void print_queue_properties(struct queue_properties *q)
 	pr_debug("Queue Address: 0x%llX\n", q->queue_address);
 	pr_debug("Queue Id: %u\n", q->queue_id);
 	pr_debug("Queue Process Vmid: %u\n", q->vmid);
-	pr_debug("Queue Read Pointer: 0x%p\n", q->read_ptr);
-	pr_debug("Queue Write Pointer: 0x%p\n", q->write_ptr);
-	pr_debug("Queue Doorbell Pointer: 0x%p\n", q->doorbell_ptr);
+	pr_debug("Queue Read Pointer: 0x%px\n", q->read_ptr);
+	pr_debug("Queue Write Pointer: 0x%px\n", q->write_ptr);
+	pr_debug("Queue Doorbell Pointer: 0x%px\n", q->doorbell_ptr);
 	pr_debug("Queue Doorbell Offset: %u\n", q->doorbell_off);
 }
 
@@ -53,14 +53,14 @@ void print_queue(struct queue *q)
 	pr_debug("Queue Address: 0x%llX\n", q->properties.queue_address);
 	pr_debug("Queue Id: %u\n", q->properties.queue_id);
 	pr_debug("Queue Process Vmid: %u\n", q->properties.vmid);
-	pr_debug("Queue Read Pointer: 0x%p\n", q->properties.read_ptr);
-	pr_debug("Queue Write Pointer: 0x%p\n", q->properties.write_ptr);
-	pr_debug("Queue Doorbell Pointer: 0x%p\n", q->properties.doorbell_ptr);
+	pr_debug("Queue Read Pointer: 0x%px\n", q->properties.read_ptr);
+	pr_debug("Queue Write Pointer: 0x%px\n", q->properties.write_ptr);
+	pr_debug("Queue Doorbell Pointer: 0x%px\n", q->properties.doorbell_ptr);
 	pr_debug("Queue Doorbell Offset: %u\n", q->properties.doorbell_off);
-	pr_debug("Queue MQD Address: 0x%p\n", q->mqd);
+	pr_debug("Queue MQD Address: 0x%px\n", q->mqd);
 	pr_debug("Queue MQD Gart: 0x%llX\n", q->gart_mqd_addr);
-	pr_debug("Queue Process Address: 0x%p\n", q->process);
-	pr_debug("Queue Device Address: 0x%p\n", q->device);
+	pr_debug("Queue Process Address: 0x%px\n", q->process);
+	pr_debug("Queue Device Address: 0x%px\n", q->device);
 }
 
 int init_queue(struct queue **q, const struct queue_properties *properties)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 4e2f379ce217..c50779aa5daa 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -275,7 +275,7 @@ static void dm_pflip_high_irq(void *interrupt_params)
 	spin_lock_irqsave(&adev->ddev->event_lock, flags);
 
 	if (amdgpu_crtc->pflip_status != AMDGPU_FLIP_SUBMITTED){
-		DRM_DEBUG_DRIVER("amdgpu_crtc->pflip_status = %d !=AMDGPU_FLIP_SUBMITTED(%d) on crtc:%d[%p] \n",
+		DRM_DEBUG_DRIVER("amdgpu_crtc->pflip_status = %d !=AMDGPU_FLIP_SUBMITTED(%d) on crtc:%d[%px] \n",
 						 amdgpu_crtc->pflip_status,
 						 AMDGPU_FLIP_SUBMITTED,
 						 amdgpu_crtc->crtc_id,
@@ -301,7 +301,7 @@ static void dm_pflip_high_irq(void *interrupt_params)
 	amdgpu_crtc->pflip_status = AMDGPU_FLIP_NONE;
 	spin_unlock_irqrestore(&adev->ddev->event_lock, flags);
 
-	DRM_DEBUG_DRIVER("%s - crtc :%d[%p], pflip_stat:AMDGPU_FLIP_NONE\n",
+	DRM_DEBUG_DRIVER("%s - crtc :%d[%px], pflip_stat:AMDGPU_FLIP_NONE\n",
 					__func__, amdgpu_crtc->crtc_id, amdgpu_crtc);
 
 	drm_crtc_vblank_put(&amdgpu_crtc->base);
@@ -463,7 +463,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 		DRM_ERROR(
 		"amdgpu: failed to initialize freesync_module.\n");
 	} else
-		DRM_DEBUG_DRIVER("amdgpu: freesync_module init done %p.\n",
+		DRM_DEBUG_DRIVER("amdgpu: freesync_module init done %px.\n",
 				adev->dm.freesync_module);
 
 	amdgpu_dm_init_color_mod();
@@ -543,7 +543,7 @@ static int detect_mst_link_for_all_connectors(struct drm_device *dev)
 		aconnector = to_amdgpu_dm_connector(connector);
 		if (aconnector->dc_link->type == dc_connection_mst_branch &&
 		    aconnector->mst_mgr.aux) {
-			DRM_DEBUG_DRIVER("DM_MST: starting TM on aconnector: %p [id: %d]\n",
+			DRM_DEBUG_DRIVER("DM_MST: starting TM on aconnector: %px [id: %d]\n",
 					aconnector, aconnector->base.base.id);
 
 			ret = drm_dp_mst_topology_mgr_set_mst(&aconnector->mst_mgr, true);
@@ -895,7 +895,7 @@ amdgpu_dm_update_connector_after_detect(struct amdgpu_dm_connector *aconnector)
 		return;
 	}
 
-	DRM_DEBUG_DRIVER("DCHPD: connector_id=%d: Old sink=%p New sink=%p\n",
+	DRM_DEBUG_DRIVER("DCHPD: connector_id=%d: Old sink=%px New sink=%px\n",
 		aconnector->connector_id, aconnector->dc_sink, sink);
 
 	mutex_lock(&dev->mode_config.mutex);
@@ -4185,7 +4185,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 
 		if (modeset_required(new_crtc_state, dm_new_crtc_state->stream, dm_old_crtc_state->stream)) {
 
-			DRM_DEBUG_DRIVER("Atomic commit: SET crtc id %d: [%p]\n", acrtc->crtc_id, acrtc);
+			DRM_DEBUG_DRIVER("Atomic commit: SET crtc id %d: [%px]\n", acrtc->crtc_id, acrtc);
 
 			if (!dm_new_crtc_state->stream) {
 				/*
@@ -4215,7 +4215,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 			acrtc->hw_mode = new_crtc_state->mode;
 			crtc->hwmode = new_crtc_state->mode;
 		} else if (modereset_required(new_crtc_state)) {
-			DRM_DEBUG_DRIVER("Atomic commit: RESET. crtc id %d:[%p]\n", acrtc->crtc_id, acrtc);
+			DRM_DEBUG_DRIVER("Atomic commit: RESET. crtc id %d:[%px]\n", acrtc->crtc_id, acrtc);
 
 			/* i.e. reset mode */
 			if (dm_old_crtc_state->stream)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 8291d74f26bc..4fc246cd6ec4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -302,7 +302,7 @@ dm_dp_create_fake_mst_encoder(struct amdgpu_dm_connector *connector)
 	struct drm_encoder *enc_master =
 		connector_funcs->best_encoder(&connector->base);
 
-	DRM_DEBUG_KMS("enc master is %p\n", enc_master);
+	DRM_DEBUG_KMS("enc master is %px\n", enc_master);
 	amdgpu_encoder = kzalloc(sizeof(*amdgpu_encoder), GFP_KERNEL);
 	if (!amdgpu_encoder)
 		return NULL;
diff --git a/drivers/gpu/drm/armada/armada_gem.c b/drivers/gpu/drm/armada/armada_gem.c
index a97f509743a5..075840a3735f 100644
--- a/drivers/gpu/drm/armada/armada_gem.c
+++ b/drivers/gpu/drm/armada/armada_gem.c
@@ -50,7 +50,7 @@ void armada_gem_free_object(struct drm_gem_object *obj)
 	struct armada_gem_object *dobj = drm_to_armada_gem(obj);
 	struct armada_private *priv = obj->dev->dev_private;
 
-	DRM_DEBUG_DRIVER("release obj %p\n", dobj);
+	DRM_DEBUG_DRIVER("release obj %px\n", dobj);
 
 	drm_gem_free_mmap_offset(&dobj->obj);
 
@@ -177,7 +177,7 @@ armada_gem_linear_back(struct drm_device *dev, struct armada_gem_object *obj)
 		obj->mapped = true;
 	}
 
-	DRM_DEBUG_DRIVER("obj %p phys %#llx dev %#llx\n", obj,
+	DRM_DEBUG_DRIVER("obj %px phys %#llx dev %#llx\n", obj,
 			 (unsigned long long)obj->phys_addr,
 			 (unsigned long long)obj->dev_addr);
 
@@ -206,7 +206,7 @@ armada_gem_alloc_private_object(struct drm_device *dev, size_t size)
 
 	drm_gem_private_object_init(dev, &obj->obj, size);
 
-	DRM_DEBUG_DRIVER("alloc private obj %p size %zu\n", obj, size);
+	DRM_DEBUG_DRIVER("alloc private obj %px size %zu\n", obj, size);
 
 	return obj;
 }
@@ -231,7 +231,7 @@ static struct armada_gem_object *armada_gem_alloc_object(struct drm_device *dev,
 	mapping = obj->obj.filp->f_mapping;
 	mapping_set_gfp_mask(mapping, GFP_HIGHUSER | __GFP_RECLAIMABLE);
 
-	DRM_DEBUG_DRIVER("alloc obj %p size %zu\n", obj, size);
+	DRM_DEBUG_DRIVER("alloc obj %px size %zu\n", obj, size);
 
 	return obj;
 }
@@ -263,7 +263,7 @@ int armada_gem_dumb_create(struct drm_file *file, struct drm_device *dev,
 	args->handle = handle;
 
 	/* drop reference from allocate - handle holds it now */
-	DRM_DEBUG_DRIVER("obj %p size %zu handle %#x\n", dobj, size, handle);
+	DRM_DEBUG_DRIVER("obj %px size %zu handle %#x\n", dobj, size, handle);
  err:
 	drm_gem_object_put_unlocked(&dobj->obj);
 	return ret;
@@ -295,7 +295,7 @@ int armada_gem_create_ioctl(struct drm_device *dev, void *data,
 	args->handle = handle;
 
 	/* drop reference from allocate - handle holds it now */
-	DRM_DEBUG_DRIVER("obj %p size %zu handle %#x\n", dobj, size, handle);
+	DRM_DEBUG_DRIVER("obj %px size %zu handle %#x\n", dobj, size, handle);
  err:
 	drm_gem_object_put_unlocked(&dobj->obj);
 	return ret;
diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 7d25c42f22db..239b010fc010 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -92,7 +92,7 @@ drm_atomic_state_init(struct drm_device *dev, struct drm_atomic_state *state)
 
 	state->dev = dev;
 
-	DRM_DEBUG_ATOMIC("Allocated atomic state %p\n", state);
+	DRM_DEBUG_ATOMIC("Allocated atomic state %px\n", state);
 
 	return 0;
 fail:
@@ -143,7 +143,7 @@ void drm_atomic_state_default_clear(struct drm_atomic_state *state)
 	struct drm_mode_config *config = &dev->mode_config;
 	int i;
 
-	DRM_DEBUG_ATOMIC("Clearing atomic state %p\n", state);
+	DRM_DEBUG_ATOMIC("Clearing atomic state %px\n", state);
 
 	for (i = 0; i < state->num_connector; i++) {
 		struct drm_connector *connector = state->connectors[i].ptr;
@@ -240,7 +240,7 @@ void __drm_atomic_state_free(struct kref *ref)
 
 	drm_atomic_state_clear(state);
 
-	DRM_DEBUG_ATOMIC("Freeing atomic state %p\n", state);
+	DRM_DEBUG_ATOMIC("Freeing atomic state %px\n", state);
 
 	if (config->funcs->atomic_state_free) {
 		config->funcs->atomic_state_free(state);
@@ -293,7 +293,7 @@ drm_atomic_get_crtc_state(struct drm_atomic_state *state,
 	state->crtcs[index].ptr = crtc;
 	crtc_state->state = state;
 
-	DRM_DEBUG_ATOMIC("Added [CRTC:%d:%s] %p state to %p\n",
+	DRM_DEBUG_ATOMIC("Added [CRTC:%d:%s] %px state to %px\n",
 			 crtc->base.id, crtc->name, crtc_state, state);
 
 	return crtc_state;
@@ -351,12 +351,12 @@ int drm_atomic_set_mode_for_crtc(struct drm_crtc_state *state,
 
 		drm_mode_copy(&state->mode, mode);
 		state->enable = true;
-		DRM_DEBUG_ATOMIC("Set [MODE:%s] for CRTC state %p\n",
+		DRM_DEBUG_ATOMIC("Set [MODE:%s] for CRTC state %px\n",
 				 mode->name, state);
 	} else {
 		memset(&state->mode, 0, sizeof(state->mode));
 		state->enable = false;
-		DRM_DEBUG_ATOMIC("Set [NOMODE] for CRTC state %p\n",
+		DRM_DEBUG_ATOMIC("Set [NOMODE] for CRTC state %px\n",
 				 state);
 	}
 
@@ -396,11 +396,11 @@ int drm_atomic_set_mode_prop_for_crtc(struct drm_crtc_state *state,
 
 		state->mode_blob = drm_property_blob_get(blob);
 		state->enable = true;
-		DRM_DEBUG_ATOMIC("Set [MODE:%s] for CRTC state %p\n",
+		DRM_DEBUG_ATOMIC("Set [MODE:%s] for CRTC state %px\n",
 				 state->mode.name, state);
 	} else {
 		state->enable = false;
-		DRM_DEBUG_ATOMIC("Set [NOMODE] for CRTC state %p\n",
+		DRM_DEBUG_ATOMIC("Set [NOMODE] for CRTC state %px\n",
 				 state);
 	}
 
@@ -710,7 +710,7 @@ drm_atomic_get_plane_state(struct drm_atomic_state *state,
 	state->planes[index].new_state = plane_state;
 	plane_state->state = state;
 
-	DRM_DEBUG_ATOMIC("Added [PLANE:%d:%s] %p state to %p\n",
+	DRM_DEBUG_ATOMIC("Added [PLANE:%d:%s] %px state to %px\n",
 			 plane->base.id, plane->name, plane_state, state);
 
 	if (plane_state->crtc) {
@@ -1111,7 +1111,7 @@ drm_atomic_get_private_obj_state(struct drm_atomic_state *state,
 
 	state->num_private_objs = num_objs;
 
-	DRM_DEBUG_ATOMIC("Added new private object %p state %p to %p\n",
+	DRM_DEBUG_ATOMIC("Added new private object %px state %px to %px\n",
 			 obj, obj_state, state);
 
 	return obj_state;
@@ -1178,7 +1178,7 @@ drm_atomic_get_connector_state(struct drm_atomic_state *state,
 	state->connectors[index].ptr = connector;
 	connector_state->state = state;
 
-	DRM_DEBUG_ATOMIC("Added [CONNECTOR:%d:%s] %p state to %p\n",
+	DRM_DEBUG_ATOMIC("Added [CONNECTOR:%d:%s] %px state to %px\n",
 			 connector->base.id, connector->name,
 			 connector_state, state);
 
@@ -1442,10 +1442,10 @@ drm_atomic_set_crtc_for_plane(struct drm_plane_state *plane_state,
 	}
 
 	if (crtc)
-		DRM_DEBUG_ATOMIC("Link plane state %p to [CRTC:%d:%s]\n",
+		DRM_DEBUG_ATOMIC("Link plane state %px to [CRTC:%d:%s]\n",
 				 plane_state, crtc->base.id, crtc->name);
 	else
-		DRM_DEBUG_ATOMIC("Link plane state %p to [NOCRTC]\n",
+		DRM_DEBUG_ATOMIC("Link plane state %px to [NOCRTC]\n",
 				 plane_state);
 
 	return 0;
@@ -1467,10 +1467,10 @@ drm_atomic_set_fb_for_plane(struct drm_plane_state *plane_state,
 			    struct drm_framebuffer *fb)
 {
 	if (fb)
-		DRM_DEBUG_ATOMIC("Set [FB:%d] for plane state %p\n",
+		DRM_DEBUG_ATOMIC("Set [FB:%d] for plane state %px\n",
 				 fb->base.id, plane_state);
 	else
-		DRM_DEBUG_ATOMIC("Set [NOFB] for plane state %p\n",
+		DRM_DEBUG_ATOMIC("Set [NOFB] for plane state %px\n",
 				 plane_state);
 
 	drm_framebuffer_assign(&plane_state->fb, fb);
@@ -1551,10 +1551,10 @@ drm_atomic_set_crtc_for_connector(struct drm_connector_state *conn_state,
 		drm_connector_get(conn_state->connector);
 		conn_state->crtc = crtc;
 
-		DRM_DEBUG_ATOMIC("Link connector state %p to [CRTC:%d:%s]\n",
+		DRM_DEBUG_ATOMIC("Link connector state %px to [CRTC:%d:%s]\n",
 				 conn_state, crtc->base.id, crtc->name);
 	} else {
-		DRM_DEBUG_ATOMIC("Link connector state %p to [NOCRTC]\n",
+		DRM_DEBUG_ATOMIC("Link connector state %px to [NOCRTC]\n",
 				 conn_state);
 	}
 
@@ -1598,7 +1598,7 @@ drm_atomic_add_affected_connectors(struct drm_atomic_state *state,
 	if (ret)
 		return ret;
 
-	DRM_DEBUG_ATOMIC("Adding all current connectors for [CRTC:%d:%s] to %p\n",
+	DRM_DEBUG_ATOMIC("Adding all current connectors for [CRTC:%d:%s] to %px\n",
 			 crtc->base.id, crtc->name, state);
 
 	/*
@@ -1682,7 +1682,7 @@ int drm_atomic_check_only(struct drm_atomic_state *state)
 	struct drm_crtc_state *crtc_state;
 	int i, ret = 0;
 
-	DRM_DEBUG_ATOMIC("checking %p\n", state);
+	DRM_DEBUG_ATOMIC("checking %px\n", state);
 
 	for_each_new_plane_in_state(state, plane, plane_state, i) {
 		ret = drm_atomic_plane_check(plane, plane_state);
@@ -1745,7 +1745,7 @@ int drm_atomic_commit(struct drm_atomic_state *state)
 	if (ret)
 		return ret;
 
-	DRM_DEBUG_ATOMIC("committing %p\n", state);
+	DRM_DEBUG_ATOMIC("committing %px\n", state);
 
 	return config->funcs->atomic_commit(state->dev, state, false);
 }
@@ -1774,7 +1774,7 @@ int drm_atomic_nonblocking_commit(struct drm_atomic_state *state)
 	if (ret)
 		return ret;
 
-	DRM_DEBUG_ATOMIC("committing %p nonblocking\n", state);
+	DRM_DEBUG_ATOMIC("committing %px nonblocking\n", state);
 
 	return config->funcs->atomic_commit(state->dev, state, true);
 }
@@ -1791,7 +1791,7 @@ static void drm_atomic_print_state(const struct drm_atomic_state *state)
 	struct drm_connector_state *connector_state;
 	int i;
 
-	DRM_DEBUG_ATOMIC("checking %p\n", state);
+	DRM_DEBUG_ATOMIC("checking %px\n", state);
 
 	for_each_new_plane_in_state(state, plane, plane_state, i)
 		drm_atomic_plane_print_state(&p, plane_state);
diff --git a/drivers/gpu/drm/drm_bufs.c b/drivers/gpu/drm/drm_bufs.c
index ba8cfe65c65b..f56a0893ef1b 100644
--- a/drivers/gpu/drm/drm_bufs.c
+++ b/drivers/gpu/drm/drm_bufs.c
@@ -236,7 +236,7 @@ static int drm_addmap_core(struct drm_device *dev, resource_size_t offset,
 			return 0;
 		}
 		map->handle = vmalloc_user(map->size);
-		DRM_DEBUG("%lu %d %p\n",
+		DRM_DEBUG("%lu %d %px\n",
 			  map->size, order_base_2(map->size), map->handle);
 		if (!map->handle) {
 			kfree(map);
@@ -793,7 +793,7 @@ int drm_legacy_addbufs_agp(struct drm_device *dev,
 			return -ENOMEM;
 		}
 
-		DRM_DEBUG("buffer %d @ %p\n", entry->buf_count, buf->address);
+		DRM_DEBUG("buffer %d @ %px\n", entry->buf_count, buf->address);
 
 		offset += alignment;
 		entry->buf_count++;
@@ -995,7 +995,7 @@ int drm_legacy_addbufs_pci(struct drm_device *dev,
 				return -ENOMEM;
 			}
 
-			DRM_DEBUG("buffer %d @ %p\n",
+			DRM_DEBUG("buffer %d @ %px\n",
 				  entry->buf_count, buf->address);
 		}
 		byte_count += PAGE_SIZE << page_order;
@@ -1156,7 +1156,7 @@ static int drm_legacy_addbufs_sg(struct drm_device *dev,
 			return -ENOMEM;
 		}
 
-		DRM_DEBUG("buffer %d @ %p\n", entry->buf_count, buf->address);
+		DRM_DEBUG("buffer %d @ %px\n", entry->buf_count, buf->address);
 
 		offset += alignment;
 		entry->buf_count++;
diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index 6fac4129e6a2..8ca8d418ca37 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -814,7 +814,7 @@ static int drm_dp_mst_wait_tx_reply(struct drm_dp_mst_branch *mstb,
 			goto out;
 		}
 	} else {
-		DRM_DEBUG_KMS("timedout msg send %p %d %d\n", txmsg, txmsg->state, txmsg->seqno);
+		DRM_DEBUG_KMS("timedout msg send %px %d %d\n", txmsg, txmsg->state, txmsg->seqno);
 
 		/* dump some state */
 		ret = -EIO;
@@ -2335,7 +2335,7 @@ static int drm_dp_mst_handle_down_rep(struct drm_dp_mst_topology_mgr *mgr)
 		mutex_unlock(&mgr->qlock);
 
 		if (!txmsg) {
-			DRM_DEBUG_KMS("Got MST reply with no msg %p %d %d %02x %02x\n",
+			DRM_DEBUG_KMS("Got MST reply with no msg %px %d %d %02x %02x\n",
 			       mstb,
 			       mgr->down_rep_recv.initial_hdr.seqno,
 			       mgr->down_rep_recv.initial_hdr.lct,
diff --git a/drivers/gpu/drm/drm_lease.c b/drivers/gpu/drm/drm_lease.c
index d345563fdff3..47baec81a817 100644
--- a/drivers/gpu/drm/drm_lease.c
+++ b/drivers/gpu/drm/drm_lease.c
@@ -248,7 +248,7 @@ static struct drm_master *drm_lease_create(struct drm_master *lessor, struct idr
 
 	/* Move the leases over */
 	lessee->leases = *leases;
-	DRM_DEBUG_LEASE("new lessee %d %p, lessor %d %p\n", lessee->lessee_id, lessee, lessor->lessee_id, lessor);
+	DRM_DEBUG_LEASE("new lessee %d %px, lessor %d %px\n", lessee->lessee_id, lessee, lessor->lessee_id, lessor);
 
 	mutex_unlock(&dev->mode_config.idr_mutex);
 	return lessee;
@@ -320,7 +320,7 @@ static void _drm_lease_revoke(struct drm_master *top)
 	 * the tree is fully connected, we can do this without recursing
 	 */
 	for (;;) {
-		DRM_DEBUG_LEASE("revoke leases for %p %d\n", master, master->lessee_id);
+		DRM_DEBUG_LEASE("revoke leases for %px %d\n", master, master->lessee_id);
 
 		/* Evacuate the lease */
 		idr_for_each_entry(&master->leases, entry, object)
@@ -564,7 +564,7 @@ int drm_mode_create_lease_ioctl(struct drm_device *dev,
 	}
 
 	/* Initialize the new file for DRM */
-	DRM_DEBUG_LEASE("Initializing the file with %p\n", lessee_file->f_op->open);
+	DRM_DEBUG_LEASE("Initializing the file with %px\n", lessee_file->f_op->open);
 	ret = lessee_file->f_op->open(lessee_file->f_inode, lessee_file);
 	if (ret)
 		goto out_lessee_file;
diff --git a/drivers/gpu/drm/drm_lock.c b/drivers/gpu/drm/drm_lock.c
index 96bb6badb818..550b462c9526 100644
--- a/drivers/gpu/drm/drm_lock.c
+++ b/drivers/gpu/drm/drm_lock.c
@@ -341,7 +341,7 @@ void drm_legacy_lock_release(struct drm_device *dev, struct file *filp)
 		return;
 
 	if (drm_legacy_i_have_hw_lock(dev, file_priv)) {
-		DRM_DEBUG("File %p released, freeing lock for context %d\n",
+		DRM_DEBUG("File %px released, freeing lock for context %d\n",
 			  filp, _DRM_LOCKING_CONTEXT(file_priv->master->lock.hw_lock->lock));
 		drm_legacy_lock_free(&file_priv->master->lock,
 				     _DRM_LOCKING_CONTEXT(file_priv->master->lock.hw_lock->lock));
diff --git a/drivers/gpu/drm/drm_scatter.c b/drivers/gpu/drm/drm_scatter.c
index 275bca44f38c..06340c07ec12 100644
--- a/drivers/gpu/drm/drm_scatter.c
+++ b/drivers/gpu/drm/drm_scatter.c
@@ -134,7 +134,7 @@ int drm_legacy_sg_alloc(struct drm_device *dev, void *data,
 	entry->handle = ScatterHandle((unsigned long)entry->virtual);
 
 	DRM_DEBUG("handle  = %08lx\n", entry->handle);
-	DRM_DEBUG("virtual = %p\n", entry->virtual);
+	DRM_DEBUG("virtual = %px\n", entry->virtual);
 
 	for (i = (unsigned long)entry->virtual, j = 0; j < pages;
 	     i += PAGE_SIZE, j++) {
@@ -213,7 +213,7 @@ int drm_legacy_sg_free(struct drm_device *dev, void *data,
 	if (!entry || entry->handle != request->handle)
 		return -EINVAL;
 
-	DRM_DEBUG("virtual  = %p\n", entry->virtual);
+	DRM_DEBUG("virtual  = %px\n", entry->virtual);
 
 	drm_sg_cleanup(entry);
 
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
index ab50090d066c..09065596463b 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
@@ -52,7 +52,7 @@ void __iomem *etnaviv_ioremap(struct platform_device *pdev, const char *name,
 	}
 
 	if (reglog)
-		dev_printk(KERN_DEBUG, &pdev->dev, "IO:region %s 0x%p %08zx\n",
+		dev_printk(KERN_DEBUG, &pdev->dev, "IO:region %s 0x%px %08zx\n",
 			   dbgname, ptr, (size_t)resource_size(res));
 
 	return ptr;
@@ -61,7 +61,7 @@ void __iomem *etnaviv_ioremap(struct platform_device *pdev, const char *name,
 void etnaviv_writel(u32 data, void __iomem *addr)
 {
 	if (reglog)
-		printk(KERN_DEBUG "IO:W %p %08x\n", addr, data);
+		printk(KERN_DEBUG "IO:W %px %08x\n", addr, data);
 
 	writel(data, addr);
 }
@@ -71,7 +71,7 @@ u32 etnaviv_readl(const void __iomem *addr)
 	u32 val = readl(addr);
 
 	if (reglog)
-		printk(KERN_DEBUG "IO:R %p %08x\n", addr, val);
+		printk(KERN_DEBUG "IO:R %px %08x\n", addr, val);
 
 	return val;
 }
diff --git a/drivers/gpu/drm/i810/i810_dma.c b/drivers/gpu/drm/i810/i810_dma.c
index 576a417690d4..00b872fd27b0 100644
--- a/drivers/gpu/drm/i810/i810_dma.c
+++ b/drivers/gpu/drm/i810/i810_dma.c
@@ -399,7 +399,7 @@ static int i810_dma_initialize(struct drm_device *dev,
 		DRM_ERROR("Can not allocate hardware status page\n");
 		return -ENOMEM;
 	}
-	DRM_DEBUG("hw status page @ %p\n", dev_priv->hw_status_page);
+	DRM_DEBUG("hw status page @ %px\n", dev_priv->hw_status_page);
 
 	I810_WRITE(0x02080, dev_priv->dma_status_page);
 	DRM_DEBUG("Enabled hardware status page\n");
diff --git a/drivers/gpu/drm/i915/i915_perf.c b/drivers/gpu/drm/i915/i915_perf.c
index abaca6edeb71..a90ca24b03ea 100644
--- a/drivers/gpu/drm/i915/i915_perf.c
+++ b/drivers/gpu/drm/i915/i915_perf.c
@@ -1473,7 +1473,7 @@ static int alloc_oa_buffer(struct drm_i915_private *dev_priv)
 
 	dev_priv->perf.oa.ops.init_oa_buffer(dev_priv);
 
-	DRM_DEBUG_DRIVER("OA Buffer initialized, gtt offset = 0x%x, vaddr = %p\n",
+	DRM_DEBUG_DRIVER("OA Buffer initialized, gtt offset = 0x%x, vaddr = %px\n",
 			 i915_ggtt_offset(dev_priv->perf.oa.oa_buffer.vma),
 			 dev_priv->perf.oa.oa_buffer.vaddr);
 
diff --git a/drivers/gpu/drm/i915/intel_display.c b/drivers/gpu/drm/i915/intel_display.c
index 3b48fd2561fe..9759257ac614 100644
--- a/drivers/gpu/drm/i915/intel_display.c
+++ b/drivers/gpu/drm/i915/intel_display.c
@@ -2732,7 +2732,7 @@ intel_alloc_initial_plane_obj(struct intel_crtc *crtc,
 	}
 
 
-	DRM_DEBUG_KMS("initial plane fb obj %p\n", obj);
+	DRM_DEBUG_KMS("initial plane fb obj %px\n", obj);
 	return true;
 
 out_unref_obj:
diff --git a/drivers/gpu/drm/i915/intel_guc_ct.c b/drivers/gpu/drm/i915/intel_guc_ct.c
index 24ad55752396..3c44c1946e66 100644
--- a/drivers/gpu/drm/i915/intel_guc_ct.c
+++ b/drivers/gpu/drm/i915/intel_guc_ct.c
@@ -49,7 +49,7 @@ static inline const char *guc_ct_buffer_type_to_str(u32 type)
 static void guc_ct_buffer_desc_init(struct guc_ct_buffer_desc *desc,
 				    u32 cmds_addr, u32 size, u32 owner)
 {
-	DRM_DEBUG_DRIVER("CT: desc %p init addr=%#x size=%u owner=%u\n",
+	DRM_DEBUG_DRIVER("CT: desc %px init addr=%#x size=%u owner=%u\n",
 			 desc, cmds_addr, size, owner);
 	memset(desc, 0, sizeof(*desc));
 	desc->addr = cmds_addr;
@@ -59,7 +59,7 @@ static void guc_ct_buffer_desc_init(struct guc_ct_buffer_desc *desc,
 
 static void guc_ct_buffer_desc_reset(struct guc_ct_buffer_desc *desc)
 {
-	DRM_DEBUG_DRIVER("CT: desc %p reset head=%u tail=%u\n",
+	DRM_DEBUG_DRIVER("CT: desc %px reset head=%u tail=%u\n",
 			 desc, desc->head, desc->tail);
 	desc->head = 0;
 	desc->tail = 0;
diff --git a/drivers/gpu/drm/i915/intel_guc_submission.c b/drivers/gpu/drm/i915/intel_guc_submission.c
index 8a8ad2fe158d..10af95e91ca1 100644
--- a/drivers/gpu/drm/i915/intel_guc_submission.c
+++ b/drivers/gpu/drm/i915/intel_guc_submission.c
@@ -928,7 +928,7 @@ guc_client_alloc(struct drm_i915_private *dev_priv,
 	if (ret)
 		goto err_vaddr;
 
-	DRM_DEBUG_DRIVER("new priority %u client %p for engine(s) 0x%x: stage_id %u\n",
+	DRM_DEBUG_DRIVER("new priority %u client %px for engine(s) 0x%x: stage_id %u\n",
 			 priority, client, client->engines, client->stage_id);
 	DRM_DEBUG_DRIVER("doorbell id %u, cacheline offset 0x%lx\n",
 			 client->doorbell_id, client->doorbell_offset);
diff --git a/drivers/gpu/drm/i915/intel_uc_fw.c b/drivers/gpu/drm/i915/intel_uc_fw.c
index 3ec0ce505b76..4c968078c61c 100644
--- a/drivers/gpu/drm/i915/intel_uc_fw.c
+++ b/drivers/gpu/drm/i915/intel_uc_fw.c
@@ -64,7 +64,7 @@ void intel_uc_fw_fetch(struct drm_i915_private *dev_priv,
 		goto fail;
 	}
 
-	DRM_DEBUG_DRIVER("%s fw size %zu ptr %p\n",
+	DRM_DEBUG_DRIVER("%s fw size %zu ptr %px\n",
 			 intel_uc_fw_type_repr(uc_fw->type), fw->size, fw);
 
 	/* Check the size of the blob before examining buffer contents */
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_gem.c b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
index f595ac816b55..ccdec81de9e3 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_gem.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
@@ -71,7 +71,7 @@ struct mtk_drm_gem_obj *mtk_drm_gem_create(struct drm_device *dev,
 	if (alloc_kmap)
 		mtk_gem->kvaddr = mtk_gem->cookie;
 
-	DRM_DEBUG_DRIVER("cookie = %p dma_addr = %pad size = %zu\n",
+	DRM_DEBUG_DRIVER("cookie = %px dma_addr = %pad size = %zu\n",
 			 mtk_gem->cookie, &mtk_gem->dma_addr,
 			 size);
 
diff --git a/drivers/gpu/drm/mga/mga_warp.c b/drivers/gpu/drm/mga/mga_warp.c
index 0b76352260a9..5b286f04f805 100644
--- a/drivers/gpu/drm/mga/mga_warp.c
+++ b/drivers/gpu/drm/mga/mga_warp.c
@@ -116,7 +116,7 @@ int mga_warp_install_microcode(drm_mga_private_t *dev_priv)
 	     rec = ihex_next_binrec(rec)) {
 		unsigned int src_size, dst_size;
 
-		DRM_DEBUG(" pcbase = 0x%08lx  vcbase = %p\n", pcbase, vcbase);
+		DRM_DEBUG(" pcbase = 0x%08lx  vcbase = %px\n", pcbase, vcbase);
 		dev_priv->warp_pipe_phys[where] = pcbase;
 		src_size = be16_to_cpu(rec->len);
 		dst_size = WARP_UCODE_SIZE(src_size);
diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 30cd514d8f7c..078e9c3183e8 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -122,7 +122,7 @@ void __iomem *msm_ioremap(struct platform_device *pdev, const char *name,
 	}
 
 	if (reglog)
-		printk(KERN_DEBUG "IO:region %s %p %08lx\n", dbgname, ptr, size);
+		printk(KERN_DEBUG "IO:region %s %px %08lx\n", dbgname, ptr, size);
 
 	return ptr;
 }
@@ -130,7 +130,7 @@ void __iomem *msm_ioremap(struct platform_device *pdev, const char *name,
 void msm_writel(u32 data, void __iomem *addr)
 {
 	if (reglog)
-		printk(KERN_DEBUG "IO:W %p %08x\n", addr, data);
+		printk(KERN_DEBUG "IO:W %px %08x\n", addr, data);
 	writel(data, addr);
 }
 
diff --git a/drivers/gpu/drm/qxl/qxl_cmd.c b/drivers/gpu/drm/qxl/qxl_cmd.c
index c0fb52c6d4ca..f6c64c5cb99f 100644
--- a/drivers/gpu/drm/qxl/qxl_cmd.c
+++ b/drivers/gpu/drm/qxl/qxl_cmd.c
@@ -381,7 +381,7 @@ void qxl_io_create_primary(struct qxl_device *qdev,
 {
 	struct qxl_surface_create *create;
 
-	DRM_DEBUG_DRIVER("qdev %p, ram_header %p\n", qdev, qdev->ram_header);
+	DRM_DEBUG_DRIVER("qdev %px, ram_header %px\n", qdev, qdev->ram_header);
 	create = &qdev->ram_header->create_surface;
 	create->format = bo->surf.format;
 	create->width = bo->surf.width;
@@ -393,7 +393,7 @@ void qxl_io_create_primary(struct qxl_device *qdev,
 		create->mem = qxl_bo_physical_address(qdev, bo, offset);
 	}
 
-	DRM_DEBUG_DRIVER("mem = %llx, from %p\n", create->mem, bo->kptr);
+	DRM_DEBUG_DRIVER("mem = %llx, from %px\n", create->mem, bo->kptr);
 
 	create->flags = QXL_SURF_FLAG_KEEP_DATA;
 	create->type = QXL_SURF_TYPE_PRIMARY;
diff --git a/drivers/gpu/drm/qxl/qxl_fb.c b/drivers/gpu/drm/qxl/qxl_fb.c
index 338891401f35..ce506e702aed 100644
--- a/drivers/gpu/drm/qxl/qxl_fb.c
+++ b/drivers/gpu/drm/qxl/qxl_fb.c
@@ -246,7 +246,7 @@ static int qxlfb_create(struct qxl_fbdev *qfbdev,
 	shadow = vmalloc(mode_cmd.pitches[0] * mode_cmd.height);
 	/* TODO: what's the usual response to memory allocation errors? */
 	BUG_ON(!shadow);
-	DRM_DEBUG_DRIVER("surface0 at gpu offset %lld, mmap_offset %lld (virt %p, shadow %p)\n",
+	DRM_DEBUG_DRIVER("surface0 at gpu offset %lld, mmap_offset %lld (virt %px, shadow %px)\n",
 			 qxl_bo_gpu_offset(qbo), qxl_bo_mmap_offset(qbo),
 			 qbo->kptr, shadow);
 	size = mode_cmd.pitches[0] * mode_cmd.height;
diff --git a/drivers/gpu/drm/qxl/qxl_ttm.c b/drivers/gpu/drm/qxl/qxl_ttm.c
index ee2340e31f06..bbbf9433d32a 100644
--- a/drivers/gpu/drm/qxl/qxl_ttm.c
+++ b/drivers/gpu/drm/qxl/qxl_ttm.c
@@ -133,7 +133,7 @@ int qxl_mmap(struct file *filp, struct vm_area_struct *vma)
 		 "filp->private_data->minor->dev->dev_private == NULL\n");
 		return -EINVAL;
 	}
-	DRM_DEBUG_DRIVER("filp->private_data = 0x%p, vma->vm_pgoff = %lx\n",
+	DRM_DEBUG_DRIVER("filp->private_data = 0x%px, vma->vm_pgoff = %lx\n",
 		  filp->private_data, vma->vm_pgoff);
 
 	r = ttm_bo_mmap(filp, vma, &qdev->mman.bdev);
diff --git a/drivers/gpu/drm/radeon/radeon_display.c b/drivers/gpu/drm/radeon/radeon_display.c
index 26129b2b082d..9f38090e89ef 100644
--- a/drivers/gpu/drm/radeon/radeon_display.c
+++ b/drivers/gpu/drm/radeon/radeon_display.c
@@ -513,7 +513,7 @@ static int radeon_crtc_page_flip_target(struct drm_crtc *crtc,
 	new_rbo = gem_to_radeon_bo(obj);
 
 	/* pin the new buffer */
-	DRM_DEBUG_DRIVER("flip-ioctl() cur_rbo = %p, new_rbo = %p\n",
+	DRM_DEBUG_DRIVER("flip-ioctl() cur_rbo = %px, new_rbo = %px\n",
 			 work->old_rbo, new_rbo);
 
 	r = radeon_bo_reserve(new_rbo, false);
diff --git a/drivers/gpu/drm/radeon/radeon_dp_mst.c b/drivers/gpu/drm/radeon/radeon_dp_mst.c
index cd8a3ee16649..44016392115e 100644
--- a/drivers/gpu/drm/radeon/radeon_dp_mst.c
+++ b/drivers/gpu/drm/radeon/radeon_dp_mst.c
@@ -193,7 +193,7 @@ static int radeon_dp_mst_get_ddc_modes(struct drm_connector *connector)
 
 	edid = drm_dp_mst_get_edid(connector, &master->mst_mgr, radeon_connector->port);
 	radeon_connector->edid = edid;
-	DRM_DEBUG_KMS("edid retrieved %p\n", edid);
+	DRM_DEBUG_KMS("edid retrieved %px\n", edid);
 	if (radeon_connector->edid) {
 		drm_mode_connector_update_edid_property(&radeon_connector->base, radeon_connector->edid);
 		ret = drm_add_edid_modes(&radeon_connector->base, radeon_connector->edid);
@@ -348,7 +348,7 @@ radeon_connector *radeon_mst_find_connector(struct drm_encoder *encoder)
 		if (!radeon_connector->is_mst_connector)
 			continue;
 
-		DRM_DEBUG_KMS("checking %p vs %p\n", connector->encoder, encoder);
+		DRM_DEBUG_KMS("checking %px vs %px\n", connector->encoder, encoder);
 		if (connector->encoder == encoder)
 			return radeon_connector;
 	}
@@ -374,7 +374,7 @@ void radeon_dp_mst_prepare_pll(struct drm_crtc *crtc, struct drm_display_mode *m
 			radeon_crtc->bpc = 8;
 	}
 
-	DRM_DEBUG_KMS("dp_clock %p %d\n", dig_connector, dig_connector->dp_clock);
+	DRM_DEBUG_KMS("dp_clock %px %d\n", dig_connector, dig_connector->dp_clock);
 	dp_clock = dig_connector->dp_clock;
 	radeon_crtc->ss_enabled =
 		radeon_atombios_get_asic_ss_info(rdev, &radeon_crtc->ss,
@@ -533,7 +533,7 @@ static bool radeon_mst_mode_fixup(struct drm_encoder *encoder,
 	dig_connector = mst_enc->connector->con_priv;
 	dig_connector->dp_lane_count = drm_dp_max_lane_count(dig_connector->dpcd);
 	dig_connector->dp_clock = drm_dp_max_link_rate(dig_connector->dpcd);
-	DRM_DEBUG_KMS("dig clock %p %d %d\n", dig_connector,
+	DRM_DEBUG_KMS("dig clock %px %d %d\n", dig_connector,
 		      dig_connector->dp_lane_count, dig_connector->dp_clock);
 	return true;
 }
@@ -547,7 +547,7 @@ static void radeon_mst_encoder_prepare(struct drm_encoder *encoder)
 
 	radeon_connector = radeon_mst_find_connector(encoder);
 	if (!radeon_connector) {
-		DRM_DEBUG_KMS("failed to find connector %p\n", encoder);
+		DRM_DEBUG_KMS("failed to find connector %px\n", encoder);
 		return;
 	}
 	radeon_encoder = to_radeon_encoder(encoder);
@@ -615,7 +615,7 @@ radeon_dp_create_fake_mst_encoder(struct radeon_connector *connector)
 	const struct drm_connector_helper_funcs *connector_funcs = connector->base.helper_private;
 	struct drm_encoder *enc_master = connector_funcs->best_encoder(&connector->base);
 
-	DRM_DEBUG_KMS("enc master is %p\n", enc_master);
+	DRM_DEBUG_KMS("enc master is %px\n", enc_master);
 	radeon_encoder = kzalloc(sizeof(*radeon_encoder), GFP_KERNEL);
 	if (!radeon_encoder)
 		return NULL;
diff --git a/drivers/gpu/drm/radeon/radeon_object.c b/drivers/gpu/drm/radeon/radeon_object.c
index edbb4cd519fd..24debb2760c3 100644
--- a/drivers/gpu/drm/radeon/radeon_object.c
+++ b/drivers/gpu/drm/radeon/radeon_object.c
@@ -639,7 +639,7 @@ int radeon_bo_get_surface_reg(struct radeon_bo *bo)
 		reg = &rdev->surface_regs[steal];
 		old_object = reg->bo;
 		/* blow away the mapping */
-		DRM_DEBUG("stealing surface reg %d from %p\n", steal, old_object);
+		DRM_DEBUG("stealing surface reg %d from %px\n", steal, old_object);
 		ttm_bo_unmap_virtual(&old_object->tbo);
 		old_object->surface_reg = -1;
 		i = steal;
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_fbdev.c b/drivers/gpu/drm/rockchip/rockchip_drm_fbdev.c
index e6650553f5d6..d90a372a6413 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_fbdev.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_fbdev.c
@@ -106,7 +106,7 @@ static int rockchip_drm_fbdev_create(struct drm_fb_helper *helper,
 	fbi->screen_size = rk_obj->base.size;
 	fbi->fix.smem_len = rk_obj->base.size;
 
-	DRM_DEBUG_KMS("FB [%dx%d]-%d kvaddr=%p offset=%ld size=%zu\n",
+	DRM_DEBUG_KMS("FB [%dx%d]-%d kvaddr=%px offset=%ld size=%zu\n",
 		      fb->width, fb->height, fb->format->depth,
 		      rk_obj->kvaddr,
 		      offset, size);
diff --git a/drivers/gpu/drm/savage/savage_bci.c b/drivers/gpu/drm/savage/savage_bci.c
index 2a5b8466d806..68ac86b83d1d 100644
--- a/drivers/gpu/drm/savage/savage_bci.c
+++ b/drivers/gpu/drm/savage/savage_bci.c
@@ -265,7 +265,7 @@ static struct drm_buf *savage_freelist_get(struct drm_device * dev)
 		return tail->buf;
 	}
 
-	DRM_DEBUG("returning NULL, tail->buf=%p!\n", tail->buf);
+	DRM_DEBUG("returning NULL, tail->buf=%px!\n", tail->buf);
 	return NULL;
 }
 
diff --git a/drivers/gpu/drm/sti/sti_gdp.c b/drivers/gpu/drm/sti/sti_gdp.c
index 9b2c47051b51..385841c46838 100644
--- a/drivers/gpu/drm/sti/sti_gdp.c
+++ b/drivers/gpu/drm/sti/sti_gdp.c
@@ -529,7 +529,7 @@ static void sti_gdp_init(struct sti_gdp *gdp)
 		gdp->node_list[i].top_field = base;
 		gdp->node_list[i].top_field_paddr = dma_addr;
 
-		DRM_DEBUG_DRIVER("node[%d].top_field=%p\n", i, base);
+		DRM_DEBUG_DRIVER("node[%d].top_field=%px\n", i, base);
 		base += sizeof(struct sti_gdp_node);
 		dma_addr += sizeof(struct sti_gdp_node);
 
@@ -539,7 +539,7 @@ static void sti_gdp_init(struct sti_gdp *gdp)
 		}
 		gdp->node_list[i].btm_field = base;
 		gdp->node_list[i].btm_field_paddr = dma_addr;
-		DRM_DEBUG_DRIVER("node[%d].btm_field=%p\n", i, base);
+		DRM_DEBUG_DRIVER("node[%d].btm_field=%px\n", i, base);
 		base += sizeof(struct sti_gdp_node);
 		dma_addr += sizeof(struct sti_gdp_node);
 	}
diff --git a/drivers/gpu/drm/sti/sti_mixer.c b/drivers/gpu/drm/sti/sti_mixer.c
index a4f45c74d678..6ea5f81dd9db 100644
--- a/drivers/gpu/drm/sti/sti_mixer.c
+++ b/drivers/gpu/drm/sti/sti_mixer.c
@@ -367,7 +367,7 @@ struct sti_mixer *sti_mixer_create(struct device *dev,
 	mixer->dev = dev;
 	mixer->id = id;
 
-	DRM_DEBUG_DRIVER("%s created. Regs=%p\n",
+	DRM_DEBUG_DRIVER("%s created. Regs=%px\n",
 			 sti_mixer_to_str(mixer), mixer->regs);
 
 	return mixer;
diff --git a/drivers/gpu/drm/sun4i/sun4i_crtc.c b/drivers/gpu/drm/sun4i/sun4i_crtc.c
index 2d7c57406715..1d1994409809 100644
--- a/drivers/gpu/drm/sun4i/sun4i_crtc.c
+++ b/drivers/gpu/drm/sun4i/sun4i_crtc.c
@@ -159,7 +159,7 @@ static int sun4i_crtc_enable_vblank(struct drm_crtc *crtc)
 {
 	struct sun4i_crtc *scrtc = drm_crtc_to_sun4i_crtc(crtc);
 
-	DRM_DEBUG_DRIVER("Enabling VBLANK on crtc %p\n", crtc);
+	DRM_DEBUG_DRIVER("Enabling VBLANK on crtc %px\n", crtc);
 
 	sun4i_tcon_enable_vblank(scrtc->tcon, true);
 
@@ -170,7 +170,7 @@ static void sun4i_crtc_disable_vblank(struct drm_crtc *crtc)
 {
 	struct sun4i_crtc *scrtc = drm_crtc_to_sun4i_crtc(crtc);
 
-	DRM_DEBUG_DRIVER("Disabling VBLANK on crtc %p\n", crtc);
+	DRM_DEBUG_DRIVER("Disabling VBLANK on crtc %px\n", crtc);
 
 	sun4i_tcon_enable_vblank(scrtc->tcon, false);
 }
diff --git a/drivers/gpu/drm/ttm/ttm_page_alloc.c b/drivers/gpu/drm/ttm/ttm_page_alloc.c
index f0481b7b60c5..32b3c1b42115 100644
--- a/drivers/gpu/drm/ttm/ttm_page_alloc.c
+++ b/drivers/gpu/drm/ttm/ttm_page_alloc.c
@@ -658,7 +658,7 @@ static void ttm_page_pool_fill_locked(struct ttm_page_pool *pool, int ttm_flags,
 			++pool->nrefills;
 			pool->npages += alloc_size;
 		} else {
-			pr_debug("Failed to fill pool (%p)\n", pool);
+			pr_debug("Failed to fill pool (%px)\n", pool);
 			/* If we have any pages left put them to the pool. */
 			list_for_each_entry(p, &new_pages, lru) {
 				++cpages;
diff --git a/drivers/gpu/drm/udl/udl_fb.c b/drivers/gpu/drm/udl/udl_fb.c
index 2ebdc6d5a76e..7032206c103f 100644
--- a/drivers/gpu/drm/udl/udl_fb.c
+++ b/drivers/gpu/drm/udl/udl_fb.c
@@ -406,7 +406,7 @@ static int udlfb_create(struct drm_fb_helper *helper,
 	drm_fb_helper_fill_fix(info, fb->pitches[0], fb->format->depth);
 	drm_fb_helper_fill_var(info, &ufbdev->helper, sizes->fb_width, sizes->fb_height);
 
-	DRM_DEBUG_KMS("allocated %dx%d vmal %p\n",
+	DRM_DEBUG_KMS("allocated %dx%d vmal %px\n",
 		      fb->width, fb->height,
 		      ufbdev->ufb.obj->vmapping);
 
diff --git a/drivers/gpu/drm/via/via_dma.c b/drivers/gpu/drm/via/via_dma.c
index d17d8f245c1a..5d5e322b7c48 100644
--- a/drivers/gpu/drm/via/via_dma.c
+++ b/drivers/gpu/drm/via/via_dma.c
@@ -332,7 +332,7 @@ static int via_cmdbuffer(struct drm_device *dev, void *data, struct drm_file *fi
 
 	LOCK_TEST_WITH_RETURN(dev, file_priv);
 
-	DRM_DEBUG("buf %p size %lu\n", cmdbuf->buf, cmdbuf->size);
+	DRM_DEBUG("buf %px size %lu\n", cmdbuf->buf, cmdbuf->size);
 
 	ret = via_dispatch_cmdbuffer(dev, cmdbuf);
 	return ret;
@@ -368,7 +368,7 @@ static int via_pci_cmdbuffer(struct drm_device *dev, void *data, struct drm_file
 
 	LOCK_TEST_WITH_RETURN(dev, file_priv);
 
-	DRM_DEBUG("buf %p size %lu\n", cmdbuf->buf, cmdbuf->size);
+	DRM_DEBUG("buf %px size %lu\n", cmdbuf->buf, cmdbuf->size);
 
 	ret = via_dispatch_pci_cmdbuffer(dev, cmdbuf);
 	return ret;
diff --git a/drivers/gpu/drm/via/via_irq.c b/drivers/gpu/drm/via/via_irq.c
index c96830ccc0ec..1c36ebfe2c45 100644
--- a/drivers/gpu/drm/via/via_irq.c
+++ b/drivers/gpu/drm/via/via_irq.c
@@ -259,7 +259,7 @@ void via_driver_irq_preinstall(struct drm_device *dev)
 	drm_via_irq_t *cur_irq;
 	int i;
 
-	DRM_DEBUG("dev_priv: %p\n", dev_priv);
+	DRM_DEBUG("dev_priv: %px\n", dev_priv);
 	if (dev_priv) {
 		cur_irq = dev_priv->via_irqs;
 
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c b/drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c
index 222c9c2123a1..edfe750b300b 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c
@@ -308,7 +308,7 @@ static int vmw_overlay_update_stream(struct vmw_private *dev_priv,
 	if (!buf)
 		return -EINVAL;
 
-	DRM_DEBUG("   %s: old %p, new %p, %spaused\n", __func__,
+	DRM_DEBUG("   %s: old %px, new %px, %spaused\n", __func__,
 		  stream->buf, buf, stream->paused ? "" : "not ");
 
 	if (stream->buf != buf) {
-- 
2.14.3
