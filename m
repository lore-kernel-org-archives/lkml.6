Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752045AbeDFKew (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 06:34:52 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:21772 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751434AbeDFKev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 06:34:51 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180406103449epoutp02ba182832cc2eeb87c751324f01ff9ed5~i0lW7ThvN1700917009epoutp02t
X-AuditID: b6c32a48-8d9ff70000000ff2-08-5ac74d492a38
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Message-id: <5AC74D48.4070604@samsung.com>
Date: Fri, 06 Apr 2018 19:34:48 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To: Andrzej Hajda <a.hajda@samsung.com>, kbuild test robot <lkp@intel.com>,
        Maciej Purski <m.purski@samsung.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org
Subject: Re: drivers/gpu/drm/bridge/sil-sii8620.c:2405: undefined reference
 to `extcon_unregister_notifier'
In-reply-to: <3920d41a-01aa-70b4-6dfc-f495cd93d453@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFKsWRmVeSWpSXmKPExsWy7bCmua6n7/Eog6/72C1urTvHanHs+kRm
        i8u75rBZvGp+xGax4OUtFgdWj/t72T0W73nJ5NG3ZRWjx+dNcgEsUak2GamJKalFCql5yfkp
        mXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUBrlRTKEnNKgUIBicXFSvp2NkX5
        pSWpChn5xSW2StGGhkZ6hgbmekZGRnomxrFWRqZAJQmpGY++PWQv6Pao+Dn7JmsDY5N5FyMn
        h4SAicSh67uZuxi5OIQEdjBKfPi1mw3C+c4osW3ndVaYqj/rDzJBJHYzSpxdvokFJMErICjx
        Y/I9IJuDg1lAXuLIpWyQMLOApsTW3evZIervMko0/e6HqteSeLR3NyOIzSKgKvFh7RY2EJsN
        KL7/xQ0wm19AUeLqj8dgNaICERI7539jB5kvIlAkcfOzO8QqY4mHy0RAKoQFciXae38wg9ic
        AvYS+3aATOcCOnkLm8T1xRcZIe53kXi3YzkbhC0s8er4FnYIW1ri2aqNUA3tjBLte+cxQzhT
        GCXOXb/HBFFlLPFsYRcTxGd8Eh2H/4IdJCHAK9HRJgRhekhsXesEUe0ocf77E2ggHmaUaN42
        hXkCo9wspOCahQiuWUjBtYCReRWjWGpBcW56arFRgYlecWJucWleul5yfu4mRnA60/LYwXjg
        nM8hRgEORiUe3oyIY1FCrIllxZW5hxglOJiVRHh3/wEK8aYkVlalFuXHF5XmpBYfYjQFhvZE
        ZinR5Hxgqs0riTc0sTQwMTMzMjezAKYvcd62AJcoIYH0xJLU7NTUgtQimD4mDk6pBsbd7WW7
        Y/XqXm96KGdwd396zMTgPSHfDx/ldVDMfjgpUmqf966eHwp/ZM3ePSxqbFVNuHXz0zy/Tb8q
        p159Ubpc497FGl2NL3YPpre7+/Jd3iJ+aso7XkWXhR+511fs/Fbn5sTU3sP37tiypq73Srwd
        U65P/v83fZqfo7Pd3plh/a9esR2bdP+MEktxRqKhFnNRcSIARR87/30DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsVy+t9jAV0P3+NRBsemG1ncWneO1eLY9YnM
        Fpd3zWGzeNX8iM1iwctbLA6sHvf3snss3vOSyaNvyypGj8+b5AJYorhsUlJzMstSi/TtErgy
        Hn17yF7Q7VHxc/ZN1gbGJvMuRk4OCQETiT/rDzJ1MXJxCAnsZJRo376ZESTBKyAo8WPyPZYu
        Rg4OZgF5iSOXskHCzALqEpPmLWIGsYUE7jNKTP2pClGuJfFo726wVhYBVYkPa7ewgdhsQPH9
        L26A2fwCihJXfzxmBBkpKhAh0X2iEiQsIlAkcfBGO9QmY4mHy0RATGGBXIndU+IhDjvKKHGp
        v5EdpJxTwF5i347djBMYBWYhuXMWwp2zkNy5gJF5FaNkakFxbnpusVGBUV5quV5xYm5xaV66
        XnJ+7iZGYBBvO6zVv4Px8ZL4Q4wCHIxKPLwZEceihFgTy4orcw8xSnAwK4nw7v4DFOJNSays
        Si3Kjy8qzUktPsQozcGiJM7Ln38sUkggPbEkNTs1tSC1CCbLxMEp1cAonOwjLtyfd0Caucep
        4PM1nWkbt0+VTmbxs0+58r6WwUKshqdZ2EHM0qY15sDa2DWu61uijitMCLodaJP+oEM8+A7P
        gTzT32lBrj1nIk9nh6/ceCDrQ5xTxYcPjUwT/D99OfZo4n7trm8Z+Q0qO+y+9mysbPys4rym
        5aaf74wfTVly04OmuCqxFGckGmoxFxUnAgBTZ2ODXgIAAA==
X-CMS-MailID: 20180406103448epcas2p171296c1eb11296bb502edd825b436356
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180406095349epcas2p22b69ac92909aeddc04a4e7a4f3c64c3f
X-RootMTR: 20180406095349epcas2p22b69ac92909aeddc04a4e7a4f3c64c3f
References: <CGME20180406095349epcas2p22b69ac92909aeddc04a4e7a4f3c64c3f@epcas2p2.samsung.com>
        <201804061737.Ugx3LMCf%fengguang.wu@intel.com>
        <3920d41a-01aa-70b4-6dfc-f495cd93d453@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrzej,

On 2018년 04월 06일 19:14, Andrzej Hajda wrote:
> Hi Chanwoo,
> 
> It looks like something went wrong, sii8620 patch was merged without
> extcon dependencies.
> Could you look at it?

If add the 'select EXTCON' to sii8620's Kconfig, it will be solved.
Is there other solution?

> 
> Regards
> Andrzej
> 
> On 06.04.2018 11:52, kbuild test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   38c23685b273cfb4ccf31a199feccce3bdcb5d83
>> commit: 688838442147d9dd94c2ef7c2c31a35cf150c5fa drm/bridge/sii8620: use micro-USB cable detection logic to detect MHL
>> date:   4 weeks ago
>> config: i386-randconfig-x0-04061534 (attached as .config)
>> compiler: gcc-5 (Debian 5.5.0-3) 5.4.1 20171010
>> reproduce:
>>         git checkout 688838442147d9dd94c2ef7c2c31a35cf150c5fa
>>         # save the attached .config to linux build tree
>>         make ARCH=i386 
>>
>> All errors (new ones prefixed by >>):
>>
>>    drivers/gpu/drm/bridge/sil-sii8620.o: In function `sii8620_remove':
>>>> drivers/gpu/drm/bridge/sil-sii8620.c:2405: undefined reference to `extcon_unregister_notifier'
>>    drivers/gpu/drm/bridge/sil-sii8620.o: In function `sii8620_extcon_init':
>>>> drivers/gpu/drm/bridge/sil-sii8620.c:2229: undefined reference to `extcon_find_edev_by_node'
>>>> drivers/gpu/drm/bridge/sil-sii8620.c:2241: undefined reference to `extcon_register_notifier'
>>    drivers/gpu/drm/bridge/sil-sii8620.o: In function `sii8620_extcon_work':
>>>> drivers/gpu/drm/bridge/sil-sii8620.c:2189: undefined reference to `extcon_get_state'
>> vim +2405 drivers/gpu/drm/bridge/sil-sii8620.c
>>
>>   2212	
>>   2213	static int sii8620_extcon_init(struct sii8620 *ctx)
>>   2214	{
>>   2215		struct extcon_dev *edev;
>>   2216		struct device_node *musb, *muic;
>>   2217		int ret;
>>   2218	
>>   2219		/* get micro-USB connector node */
>>   2220		musb = of_graph_get_remote_node(ctx->dev->of_node, 1, -1);
>>   2221		/* next get micro-USB Interface Controller node */
>>   2222		muic = of_get_next_parent(musb);
>>   2223	
>>   2224		if (!muic) {
>>   2225			dev_info(ctx->dev, "no extcon found, switching to 'always on' mode\n");
>>   2226			return 0;
>>   2227		}
>>   2228	
>>> 2229		edev = extcon_find_edev_by_node(muic);
>>   2230		of_node_put(muic);
>>   2231		if (IS_ERR(edev)) {
>>   2232			if (PTR_ERR(edev) == -EPROBE_DEFER)
>>   2233				return -EPROBE_DEFER;
>>   2234			dev_err(ctx->dev, "Invalid or missing extcon\n");
>>   2235			return PTR_ERR(edev);
>>   2236		}
>>   2237	
>>   2238		ctx->extcon = edev;
>>   2239		ctx->extcon_nb.notifier_call = sii8620_extcon_notifier;
>>   2240		INIT_WORK(&ctx->extcon_wq, sii8620_extcon_work);
>>> 2241		ret = extcon_register_notifier(edev, EXTCON_DISP_MHL, &ctx->extcon_nb);
>>   2242		if (ret) {
>>   2243			dev_err(ctx->dev, "failed to register notifier for MHL\n");
>>   2244			return ret;
>>   2245		}
>>   2246	
>>   2247		return 0;
>>   2248	}
>>   2249	
>>   2250	static inline struct sii8620 *bridge_to_sii8620(struct drm_bridge *bridge)
>>   2251	{
>>   2252		return container_of(bridge, struct sii8620, bridge);
>>   2253	}
>>   2254	
>>   2255	static int sii8620_attach(struct drm_bridge *bridge)
>>   2256	{
>>   2257		struct sii8620 *ctx = bridge_to_sii8620(bridge);
>>   2258	
>>   2259		sii8620_init_rcp_input_dev(ctx);
>>   2260	
>>   2261		return sii8620_clear_error(ctx);
>>   2262	}
>>   2263	
>>   2264	static void sii8620_detach(struct drm_bridge *bridge)
>>   2265	{
>>   2266		struct sii8620 *ctx = bridge_to_sii8620(bridge);
>>   2267	
>>   2268		rc_unregister_device(ctx->rc_dev);
>>   2269	}
>>   2270	
>>   2271	static enum drm_mode_status sii8620_mode_valid(struct drm_bridge *bridge,
>>   2272						 const struct drm_display_mode *mode)
>>   2273	{
>>   2274		struct sii8620 *ctx = bridge_to_sii8620(bridge);
>>   2275		bool can_pack = ctx->devcap[MHL_DCAP_VID_LINK_MODE] &
>>   2276				MHL_DCAP_VID_LINK_PPIXEL;
>>   2277		unsigned int max_pclk = sii8620_is_mhl3(ctx) ? MHL3_MAX_LCLK :
>>   2278							       MHL1_MAX_LCLK;
>>   2279		max_pclk /= can_pack ? 2 : 3;
>>   2280	
>>   2281		return (mode->clock > max_pclk) ? MODE_CLOCK_HIGH : MODE_OK;
>>   2282	}
>>   2283	
>>   2284	static bool sii8620_mode_fixup(struct drm_bridge *bridge,
>>   2285				       const struct drm_display_mode *mode,
>>   2286				       struct drm_display_mode *adjusted_mode)
>>   2287	{
>>   2288		struct sii8620 *ctx = bridge_to_sii8620(bridge);
>>   2289		int max_lclk;
>>   2290		bool ret = true;
>>   2291	
>>   2292		mutex_lock(&ctx->lock);
>>   2293	
>>   2294		max_lclk = sii8620_is_mhl3(ctx) ? MHL3_MAX_LCLK : MHL1_MAX_LCLK;
>>   2295		if (max_lclk > 3 * adjusted_mode->clock) {
>>   2296			ctx->use_packed_pixel = 0;
>>   2297			goto end;
>>   2298		}
>>   2299		if ((ctx->devcap[MHL_DCAP_VID_LINK_MODE] & MHL_DCAP_VID_LINK_PPIXEL) &&
>>   2300		    max_lclk > 2 * adjusted_mode->clock) {
>>   2301			ctx->use_packed_pixel = 1;
>>   2302			goto end;
>>   2303		}
>>   2304		ret = false;
>>   2305	end:
>>   2306		if (ret) {
>>   2307			u8 vic = drm_match_cea_mode(adjusted_mode);
>>   2308	
>>   2309			if (!vic) {
>>   2310				union hdmi_infoframe frm;
>>   2311				u8 mhl_vic[] = { 0, 95, 94, 93, 98 };
>>   2312	
>>   2313				/* FIXME: We need the connector here */
>>   2314				drm_hdmi_vendor_infoframe_from_display_mode(
>>   2315					&frm.vendor.hdmi, NULL, adjusted_mode);
>>   2316				vic = frm.vendor.hdmi.vic;
>>   2317				if (vic >= ARRAY_SIZE(mhl_vic))
>>   2318					vic = 0;
>>   2319				vic = mhl_vic[vic];
>>   2320			}
>>   2321			ctx->video_code = vic;
>>   2322			ctx->pixel_clock = adjusted_mode->clock;
>>   2323		}
>>   2324		mutex_unlock(&ctx->lock);
>>   2325		return ret;
>>   2326	}
>>   2327	
>>   2328	static const struct drm_bridge_funcs sii8620_bridge_funcs = {
>>   2329		.attach = sii8620_attach,
>>   2330		.detach = sii8620_detach,
>>   2331		.mode_fixup = sii8620_mode_fixup,
>>   2332		.mode_valid = sii8620_mode_valid,
>>   2333	};
>>   2334	
>>   2335	static int sii8620_probe(struct i2c_client *client,
>>   2336				 const struct i2c_device_id *id)
>>   2337	{
>>   2338		struct device *dev = &client->dev;
>>   2339		struct sii8620 *ctx;
>>   2340		int ret;
>>   2341	
>>   2342		ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
>>   2343		if (!ctx)
>>   2344			return -ENOMEM;
>>   2345	
>>   2346		ctx->dev = dev;
>>   2347		mutex_init(&ctx->lock);
>>   2348		INIT_LIST_HEAD(&ctx->mt_queue);
>>   2349	
>>   2350		ctx->clk_xtal = devm_clk_get(dev, "xtal");
>>   2351		if (IS_ERR(ctx->clk_xtal)) {
>>   2352			dev_err(dev, "failed to get xtal clock from DT\n");
>>   2353			return PTR_ERR(ctx->clk_xtal);
>>   2354		}
>>   2355	
>>   2356		if (!client->irq) {
>>   2357			dev_err(dev, "no irq provided\n");
>>   2358			return -EINVAL;
>>   2359		}
>>   2360		irq_set_status_flags(client->irq, IRQ_NOAUTOEN);
>>   2361		ret = devm_request_threaded_irq(dev, client->irq, NULL,
>>   2362						sii8620_irq_thread,
>>   2363						IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
>>   2364						"sii8620", ctx);
>>   2365		if (ret < 0) {
>>   2366			dev_err(dev, "failed to install IRQ handler\n");
>>   2367			return ret;
>>   2368		}
>>   2369	
>>   2370		ctx->gpio_reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
>>   2371		if (IS_ERR(ctx->gpio_reset)) {
>>   2372			dev_err(dev, "failed to get reset gpio from DT\n");
>>   2373			return PTR_ERR(ctx->gpio_reset);
>>   2374		}
>>   2375	
>>   2376		ctx->supplies[0].supply = "cvcc10";
>>   2377		ctx->supplies[1].supply = "iovcc18";
>>   2378		ret = devm_regulator_bulk_get(dev, 2, ctx->supplies);
>>   2379		if (ret)
>>   2380			return ret;
>>   2381	
>>   2382		ret = sii8620_extcon_init(ctx);
>>   2383		if (ret < 0) {
>>   2384			dev_err(ctx->dev, "failed to initialize EXTCON\n");
>>   2385			return ret;
>>   2386		}
>>   2387	
>>   2388		i2c_set_clientdata(client, ctx);
>>   2389	
>>   2390		ctx->bridge.funcs = &sii8620_bridge_funcs;
>>   2391		ctx->bridge.of_node = dev->of_node;
>>   2392		drm_bridge_add(&ctx->bridge);
>>   2393	
>>   2394		if (!ctx->extcon)
>>   2395			sii8620_cable_in(ctx);
>>   2396	
>>   2397		return 0;
>>   2398	}
>>   2399	
>>   2400	static int sii8620_remove(struct i2c_client *client)
>>   2401	{
>>   2402		struct sii8620 *ctx = i2c_get_clientdata(client);
>>   2403	
>>   2404		if (ctx->extcon) {
>>> 2405			extcon_unregister_notifier(ctx->extcon, EXTCON_DISP_MHL,
>>   2406						   &ctx->extcon_nb);
>>   2407			flush_work(&ctx->extcon_wq);
>>   2408			if (ctx->cable_state > 0)
>>   2409				sii8620_cable_out(ctx);
>>   2410		} else {
>>   2411			sii8620_cable_out(ctx);
>>   2412		}
>>   2413		drm_bridge_remove(&ctx->bridge);
>>   2414	
>>   2415		return 0;
>>   2416	}
>>   2417	
>>
>> ---
>> 0-DAY kernel test infrastructure                Open Source Technology Center
>> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 
> 
> 
> 

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
