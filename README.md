# hama-smart-cam

##bootlog##


U-Boot 2013.10.0-V3.1.28_bchV1.0.00 (Apr 12 2023 - 14:09:26)

DRAM:  64 MiB
efuse_read:0x00000006
8 MiB
sd detect gpio mode:84!
mmc_sd: 0
In:    serial
Out:   serial
Err:   serial
Net:   led init.
red led init:1.
No ethernet found.
MMC: detect card present
mmc/sd share pin!
send cmd 8 error, status = 2004
block rw command 8 is failed!
MMC: ak mmc mmc_send_if_cond Err!
** Bad device mmc 0 **
KERNEL: size:0x00180000, offset:0x00040000

SF: 1572864 bytes @ 0x40000 Read: OK
## Booting kernel from Legacy Image at 80008000 ...
   Image Name:   Linux-4.4.192V2.1
   Image Type:   ARM Linux Kernel Image (uncompressed)
   Data Size:    1570664 Bytes = 1.5 MiB
   Load Address: 80008000
   Entry Point:  80008040
   Verifying Checksum ... OK
   XIP Kernel Image ... OK
   kernel loaded at 0x80008000, end = 0x80187768
using: FDT

Starting kernel ...

Uncompressing Linux... done, booting the kernel.
Booting Linux on physical CPU 0x0
Linux version 4.4.192V2.1 (hutong@ubuntu) (gcc version 4.9.4 (Buildroot 2018.02.7_V1.0.03-g9ff3371) ) #1 Wed Apr 2
CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=0005317f
CPU: VIVT data cache, VIVT instruction cache
Machine model: ak3918ev330 dev board
Memory policy: Data cache writeback
ANYKA CPU AK39XXEV330 (ID 0x20160101)
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 16256
Kernel command line: console=ttySAK0,115200n8 root=/dev/mtdblock5 rootfstype=squashfs init=/sbin/init mtdparts=spM
PID hash table entries: 256 (order: -2, 1024 bytes)
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 35588K/65536K available (3078K kernel code, 116K rwdata, 980K rodata, 132K init, 188K bss, 29948K reserve)
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
    vmalloc : 0xc4800000 - 0xff800000   ( 944 MB)
    lowmem  : 0xc0000000 - 0xc4000000   (  64 MB)
    modules : 0xbf000000 - 0xc0000000   (  16 MB)
      .text : 0xc0008000 - 0xc03fed44   (4060 kB)
      .init : 0xc03ff000 - 0xc0420000   ( 132 kB)
      .data : 0xc0420000 - 0xc043d150   ( 117 kB)
       .bss : 0xc043d150 - 0xc046c2d8   ( 189 kB)
SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
NR_IRQS:126
ak39ev330_clk: CPU(JCLK): 708(Mhz)
ak39ev330_clk: MEMDDR2(DPHY): 354(Mhz)
ak39ev330_clk: VCLK: 320(Mhz)
ak-timer: ak_timer_init
clocksource: ak_cs_timer: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 159271703898 ns
sched_clock: 32 bits at 12MHz, resolution 83ns, wraps every 178956970966ns
Calibrating delay loop... 351.43 BogoMIPS (lpj=1757184)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
CPU: Testing write buffer coherency: ok
Setting up static identity map for 0x80008400 - 0x8000843c
devtmpfs: initialized
clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
futex hash table entries: 256 (order: -1, 3072 bytes)
pinctrl core: initialized pinctrl subsystem
NET: Registered protocol family 16
DMA: preallocated 256 KiB pool for atomic coherent allocations
On-chip L2 memory initialized
ak-pinctrl 20170000.gpio: ak_pinctrl_probe 1958
ak_ev330_pinctrl: ak_pinctrl_probe irq: 15
media: Linux media interface: v0.10
Linux video capture interface: v2.00
clocksource: Switched to clocksource ak_cs_timer
NET: Registered protocol family 2
TCP established hash table entries: 1024 (order: 0, 4096 bytes)
TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
TCP: Hash tables configured (established 1024 bind 1024)
UDP hash table entries: 256 (order: 0, 4096 bytes)
UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
NET: Registered protocol family 1
squashfs: version 4.0 (2009/01/31) Phillip Lougher
jffs2: version 2.2. © 2001-2006 Red Hat, Inc.
jitterentropy: Initialization failed with host not compliant with requirements: 2
io scheduler noop registered (default)
AKxx uart driver init, (c) 2013 ANYKA
20130000.uart0: ttySAK0 at MMIO 0x20130000 (irq = 10, base_baud = 10000000) is a AK
console [ttySAK0] enabled
loop: module loaded
Start to init Anyka SPI Flash...
init Anyka SPI Nand Flash driver
spi0 new hz is 40000000, div is 2(change).
ak spiflash probe enter.
akspi flash ID: 0x00204017
ak-spiflash spi0.0: xm25qh64c (16384 Kbytes)
8 cmdlinepart partitions found on MTD device spi0.0
Creating 8 MTD partitions on "spi0.0":
0x000000000000-0x000000032000 : "UBOOT"
0x000000032000-0x000000033000 : "ENV"
0x000000033000-0x000000034000 : "ENVBK"
0x000000034000-0x000000040000 : "DTB"
0x000000040000-0x0000001c0000 : "KERNEL"
0x0000001c0000-0x0000002c0000 : "ROOTFS"
0x0000002c0000-0x000000300000 : "CONFIG"
0x000000300000-0x000000800000 : "APP"
Init AK SPI Flash finish.
akspi master SPI0 initialize success, use for PIO mode.
i2c /dev entries driver
ak_wdt_init: watchdog register...
NET: Registered protocol family 17
sctp: Hash tables configured (established 512 bind 1024)

VFS: Mounted root (squashfs filesystem) readonly on device 31:5.
devtmpfs: mounted
Freeing unused kernel memory: 132K
mount all file system...
**************************
    Love Linux ! ! !
**************************
/bin/mount -t squashfs /dev/mtdblock7 /usr
/bin/mount -t jffs2 /dev/mtdblock6 /etc/config
starting mdev...

anyka login: install sc2336 mipi driver
sc2336_probe Apr 21 2023 16:46:59
id:cb3a
i2c i2c-0: sc2336 Probed success, subdev:c30adc14
ak_uio: register uio device successfully with irq: 2!
ak_motor_probe
ak_motor_probe
No TF-Card for F/W Update.
The Version Path "/mnt" Is Not Exist *.bin.
      Current FileName:

No F/W in TF-Card for Update.
rm: can't remove '/etc/config/shadow': No such file or directory
dd: can't open '/mnt/_ak39_factory.ini': No such file or directory
dd: can't open '/mnt/_ht_ap_mode.conf': No such file or directory
dd: can't open '/mnt/_ht_av_tuning.conf': No such file or directory
dd: can't open '/mnt/ftp_config.ini': No such file or directory
wifi run sta mode
killall: wpa_supplicant: no process killed
killall: udhcpc: no process killed
killall: udhcpd: no process killed
killall: hostapd: no process killed
rmmod: can't unload module 'rtl8188ftv': No such file or directory
rmmod: can't unload module 'ak_hcd': No such file or directory
rmmod: can't unload module 'usbcore': No such file or directory

rmmod: can't unload module 'usb_common': No such file or directory
rmmod: can't unload module 'cfg80211': No such file or directory
Fixed MAC 78:22:88:B8:21:11
start service......
sh: can't open '/usr/sbin/onvif_start.sh': No such file or directory
start ipc service......
***************************************
*****A monitor daemon has running!*****
***************************************
********** Watch Dog Enabled! **********
watchdog timeout = 10(s)
enter monitor_thread
##end##


##viehleicht lösung##
![236368251-974c4ec9-2f4a-4e8d-ab82-9cdafefcf59f](https://github.com/user-attachments/assets/cf70f995-9d51-4919-83e2-67935e5f62eb)


